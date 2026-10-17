# Why CFI is disabled in this build

`args.gn` ships with `is_cfi = false`. This is a deliberate deviation from
Vanadium, which enables CFI on Android, and it deserves an explicit record.

## What happened

Vanadium enables `is_cfi = true` and `use_cfi_cast = true`. Building with those
flags succeeds, but the resulting **host build tools crash on startup**:

```
$ out\Release\protoc.exe --cpp_out=... protos/perfetto/protovm/vm_program.proto
exit=-1073741795          # 0xC0000409 STATUS_STACK_BUFFER_OVERRUN
```

`protoc --version` succeeded, so the binary was not corrupt — it fast-failed as
soon as it did real work. Three observations pinned the cause:

| Experiment | Result |
|---|---|
| `protoc --version` | exit 0 |
| `protoc --cpp_out` | 0xC0000409 |
| Same binary copied to a clean directory | 0xC0000409 (not a DLL conflict) |
| `dbghelp.dll` removed from out\Release | 0xC0000409 (not our SDK fallback) |
| `is_cfi = false`, rebuild `protoc` | **exit 0** |
| `is_cfi = false`, rebuild `cppgen_plugin` | **exit 0** |

The error code is the tell. On x86-64, LLVM lowers `llvm.trap` to `ud2`
(0xC000001D), but on Windows it lowers it to `__fastfail`, which surfaces as
`0xC0000409`. CFI with `-fsanitize=cfi-vcall`/`cfi-derived-cast` traps on a
check failure, so a CFI check firing inside protoc produces exactly this code.
The build reported it as `Protoc has returned non-zero status: 3221225501`.

## Why this is an acceptable trade

Windows does not need `is_cfi` for control-flow integrity — it has **Control Flow
Guard**, which Chromium enables natively on Windows. The compiler command line
already contains `/guard:cf`:

```
... -fsanitize=cfi-vcall ... /guard:cf /MT ...
```

So with `is_cfi = false` the browser still gets platform-level control-flow
enforcement via CFG. What is lost is Clang's CFI instrumentation on top of it.

This matches the project's stated approach: where an Android/GrapheneOS hardening
feature has a genuine Windows counterpart, use the Windows counterpart rather
than forcing the Android mechanism into an unsupported configuration.

## How to revisit

If CFI is wanted back, the failing pieces are the **host tools**, not the browser.
The promising route is to keep `is_cfi = true` for the target toolchain while
building host tools (`protoc`, `cppgen_plugin`) without it — a per-toolchain
override in `//build/config/compiler` rather than a global switch. That was not
attempted here.
