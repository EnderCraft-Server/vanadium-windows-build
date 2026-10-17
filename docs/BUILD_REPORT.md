# Build report

Full timeline of the build, including every blocker and its resolution.

## Summary

| | |
|---|---|
| Upstream | Chromium 155.0.8059.84 (commit `5869fe313571d75152b77813cf0a4ee26a4e6df0`) |
| Target | Windows x64, `is_official_build = true`, `is_component_build = false` |
| Vanadium patches applied | 85 of 309 |
| Final compile | 1h 5m 4s, 9254 steps, succeeded |
| Total wall-clock including fetches and failures | ~4h |

## Blockers encountered, in order

| # | Symptom | Real cause | Resolution |
|---|---|---|---|
| 1 | `No supported Visual Studio can be found` | Build Tools installs to `Program Files (x86)`, `vs_toolchain.py` only probes `%ProgramFiles%` | export `vs2022_install` (supported override) |
| 2 | `include\10.0.28000.0\um does not exist` | Chromium 155 pins SDK 28000; not installable via VS 2022 catalog or winget | retarget `SDK_VERSION` to 10.0.26100.0 in two files |
| 3 | `dbghelp.dll not found in Windows Kits\10\Debuggers\x64` | "Debugging Tools for Windows" is an optional SDK feature with no VS component | fall back to `%SystemRoot%\System32\dbghelp.dll` |
| 4 | `unknown type name 'FILE_INFO_BY_HANDLE_CLASS'` | SDK 26100 has no `NTDDI_WIN11_BR`; the undefined macro silently disabled SDK declarations | retarget `NTDDI_VERSION` to `NTDDI_WIN11_GE` |
| 5 | `#error Windows 10.0.28000.0 SDK or higher required` | `base/win/windows_version.cc` gates on `defined(NTDDI_WIN11_BR)` | alias `NTDDI_WIN11_BR` to `NTDDI_WIN11_GE` |
| 6 | `protoc` exits `0xC0000409` | `is_cfi=true`; LLVM lowers `llvm.trap` to `__fastfail` on Windows | disable CFI, rely on Windows CFG (`/guard:cf`) |
| 7 | `BUILDFLAG_INTERNAL_USE_LOGIN_DATABASE_AS_BACKEND is not defined` | Vanadium patch 0266 assumes an Android-only buildflag | revert 0266 (Windows already has a local password backend) |
| 8 | `static assertion failed: kContentSettingsTypeGroupNames` | Vanadium patch 0018 adds `NUM_TYPES_CHROMIUM` sentinel for Android-only downstream types | revert 0018 |

Each of 1-6 is documented in `docs/ENVIRONMENT_FIXES.md` and captured in
`patches/environment/0001-host-environment-fixes.patch`; 6 additionally in
`docs/CFI_DECISION.md`; 7-8 in `docs/PATCH_DEVIATIONS.md`.

## Time budget

| Phase | Duration |
|---|---|
| Toolchain install (MSVC + SDK) | ~2 min |
| depot_tools bootstrap | ~1 min |
| `gclient sync` (27 GB source + PGO profiles + hooks) | ~19 min |
| Patch triage + application | ~8 min |
| Failures 1-5 resolution + retries | ~45 min |
| Full compile attempts before CFI fix | ~2 h (invalidated by flag change) |
| Final compile | 1 h 5 m |
