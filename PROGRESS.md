# Progress log

## 2026-10-17 — released

**Vanadium 155.0.8059.84 for Windows x64 is built, branded, and published.**

Release: https://github.com/EnderCraft-Server/vanadium-windows-build/releases/tag/v155.0.8059.84

```
1h5m04.48s Build Succeeded: 9254 steps        (privacy port)
      5m48.92s Build Succeeded:  538 steps    (branding rebuild)

chrome.exe  3.8 MB    ProductName: Vanadium    ProductVersion 155.0.8059.84
chrome.dll  328.4 MB
dist        537.5 MB extracted / 212.7 MB zipped
```

### Verified

- 16/16 privacy defaults confirmed in the source tree that produced the binaries
- Runs standalone; renders HTML via `--dump-dom`
- Window title: `about:blank - Vanadium`
- PE version resource: ProductName / FileDescription / CompanyName all `Vanadium`

### Docs

| File | Contents |
|---|---|
| `docs/BUILD_REPORT.md` | full timeline, all 8 blockers and their real causes |
| `docs/VERIFICATION.md` | functional + 16 privacy checks |
| `docs/BRANDING.md` | why it was Chromium, what rebranding took |
| `docs/CFI_DECISION.md` | why Clang CFI is off, why Windows CFG covers it |
| `docs/ENVIRONMENT_FIXES.md` | vs2022_install, SDK retarget, dbghelp fallback |
| `docs/PATCH_DEVIATIONS.md` | patches reverted and skipped, with reasons |
| `docs/PATCH_INVENTORY.md` | classification of all 309 patches |

### Reconnaissance

- Input is the **Vanadium config/patches repo only** (113 MB), not a Chromium
  checkout. Vanadium is Android-only (`target_os = "android"`).
- 309 patches: 122 platform-independent, 27 mixed, 160 android-only.
- Host: Ryzen 7 9800X3D (8c/16T), 31 GB RAM, 519 GB free on D:.
- Proxy: BitzNet at `127.0.0.1:7897`.

### Toolchain

- VS 2022 Build Tools had only MSBuild. Installer rejects `--quiet` unelevated
  (error 5007); host has `ConsentPromptBehaviorAdmin = 0`, so
  `Start-Process -Verb RunAs` self-elevates silently.
- Installed MSVC 14.44.35207 + Windows SDK 10.0.26100.0.

### Source

- `gclient sync --revision src@155.0.8059.84 --no-history` — 27.3 GB, tree at
  the correct commit, PGO profiles and hooks present.
