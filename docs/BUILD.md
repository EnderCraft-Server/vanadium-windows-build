# Build

## Prerequisites (already satisfied on the build host)

- Visual Studio 2022 Build Tools with `Microsoft.VisualStudio.Workload.VCTools`,
  MSVC 14.44.35207, Windows SDK 10.0.26100.0
- depot_tools
- ~150 GB free disk

Install the C++ toolchain (needs elevation):

```powershell
.\scripts\install_vs.ps1
```

## 1. Fetch the source

```powershell
.\scripts\fetch_chromium.ps1
```

Pins `src` to tag `155.0.8059.84`. Requires a working proxy for
chromium.googlesource.com; the script reads it from `$env:HTTP_PROXY`.

## 2. Apply the ported patch set

```powershell
.\scripts\apply_patches.ps1
```

To see what applies before changing anything:

```powershell
.\scripts\test_patches.ps1     # writes patch_check.csv
```

## 3. Configure

```powershell
copy args.gn D:\chromium\src\out\Release\args.gn
```

## 4. Build

```powershell
.\scripts\build.ps1
```

`autoninja -C out\Release chrome`. Expect roughly 2-4 hours on 8c/16T with 32 GB RAM.

## 5. Run

```powershell
D:\chromium\src\out\Release\chrome.exe
```
