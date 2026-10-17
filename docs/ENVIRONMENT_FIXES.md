# Host environment fixes

Chromium 155.0.8059.84 could not be configured on this host without three
adjustments. All three are recorded here and, where they touch Chromium source,
captured as a patch in `patches/environment/0001-host-environment-fixes.patch`.

None of them change runtime privacy or security behavior.

## 1. Visual Studio not detected: `vs2022_install`

**Symptom**

```
Exception: No supported Visual Studio can be found.
Supported versions are: 18.0 (2026), 17.0 (2022), 16.0 (2019), 15.0 (2017).
ERROR at //build/config/win/visual_studio_version.gni:29:7
```

**Cause**

`build/vs_toolchain.py` resolves VS 2022 through `MSVC_LOCATION`, which maps
2022 to `%ProgramFiles%\Microsoft Visual Studio\2022\<edition>`.
Visual Studio **Build Tools** installs to
`%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools`, so the probe
never finds it.

**Fix**

`vs_toolchain.py` checks `vs2022_install` *before* the built-in table, so setting
that environment variable is the supported override. No source change is needed;
`scripts/build.ps1` resolves the path with `vswhere` and exports it.

## 2. Windows SDK version mismatch: 10.0.28000.0 → 10.0.26100.0

**Symptom**

```
Path "C:\Program Files (x86)\Windows Kits\10\include\10.0.28000.0\um"
from environment variable "include" does not exist.
```

**Cause**

Chromium 155 pins `SDK_VERSION = '10.0.28000.0'` in two files. SDK 28000 is not
installable on this host: the Visual Studio 2022 catalog only offers 19041,
22621 and 26100, and `winget` only offers 17134 and 18362.

**Fix**

Retargeted to `10.0.26100.0` (the newest SDK present) in:

- `build/vs_toolchain.py`
- `build/toolchain/win/setup_toolchain.py`

Risk: if Chromium 155 uses an API introduced in SDK 28000, compilation fails at
that site. Any such error surfaces as a normal missing-declaration error and is
fixable in place.

## 3. Missing `dbghelp.dll`: fall back to System32

**Symptom**

```
Exception: dbghelp.dll not found in
"C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\dbghelp.dll"
You must install Windows 10 SDK version 10.0.26100.0 including the
"Debugging Tools for Windows" feature.
```

**Cause**

"Debugging Tools for Windows" is an optional SDK feature with no corresponding
component in the VS 2022 catalog, and the standalone SDK installer is not
available here.

**Fix**

`_CopyDebugger()` in `build/vs_toolchain.py` now falls back to
`%SystemRoot%\System32\<dll>` when the SDK `Debuggers` directory lacks the file.
This is the same Microsoft implementation of dbghelp, shipped by Windows itself.

Impact: `dbghelp.dll` is used for crash-dump symbolization. This build has
`enable_reporting = false`, so the affected path is not exercised at runtime.
