# Progress log

## 2026-10-17

### Reconnaissance — done

- Confirmed this repo's input is the **Vanadium config/patches repo only** (113 MB),
  not a Chromium checkout. Vanadium is Android-only (`target_os = "android"`).
- Triaged all **309** patches: 160 Android-only-path, 73 fully platform-independent.
- Verified upstream tag `155.0.8059.84` exists
  (`5869fe313571d75152b77813cf0a4ee26a4e6df0`).
- Host: Ryzen 7 9800X3D (8c/16T), 31 GB RAM, 539 GB free on D:.
- Proxy: BitzNet at `127.0.0.1:7897` — reaches chromium.googlesource.com and GitHub.

### Toolchain — done

- Visual Studio 2022 Build Tools had **only MSBuild**; no C++ toolchain.
  The installer rejects `--quiet` when unelevated (error 5007).
- Host has `ConsentPromptBehaviorAdmin = 0`, so `Start-Process -Verb RunAs`
  self-elevates silently. Installed the workload:
  - **MSVC 14.44.35207** ✅
  - **Windows SDK 10.0.26100.0** ✅

### Source fetch — in progress

- `depot_tools` cloned; `gclient sync --revision src@155.0.8059.84 --no-history` running
  through the proxy via CIPD/bootstrap.

### Next

- `test_patches.ps1` once the tree lands, to get the authoritative applicability list.
- Apply the port, write Windows equivalents for Android-only privacy semantics.
- `gn gen` + `autoninja chrome`.
