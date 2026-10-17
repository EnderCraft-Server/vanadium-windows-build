# Patches applied, skipped, and reverted

Port of the Vanadium 155.0.8059.84.0 patch set onto Chromium 155.0.8059.84 for
Windows x64. `scripts/apply_patches.ps1` records the full machine-readable result
in `apply_report.csv`; this file records the judgement calls.

## Result

| Outcome | Count |
|---|---|
| applied | 85 |
| conflict (not applied) | 3 |
| skipped: Vanadium-tree scaffolding | 136 |
| skipped: Android-only paths | 65 |
| skipped: build/resource only | 20 |

## Reverted after applying

### 0266 - Restore file name refs for password manager local database

**Reverted.** The patch assumes Vanadium's `use_login_database_as_backend` build
flag, which Vanadium only defines for Android (it is added by patch 0265, which
is Android build scaffolding and was not applied here). With the patch in place
the Windows build fails:

```
password_manager_constants.h(16,31): error: function-like macro
'BUILDFLAG_INTERNAL_USE_LOGIN_DATABASE_AS_BACKEND' is not defined
  #if !BUILDFLAG(IS_ANDROID) || BUILDFLAG(USE_LOGIN_DATABASE_AS_BACKEND)
```

followed by undeclared `kLoginDataForAccountFileName` /
`kLoginDataForProfileFileName` in `password_store_factory_util.cc`, and the
same errors in `possible_username_data.cc` and
`password_manager_client_helper.cc`.

**Why reverting is correct rather than a workaround:** this patch exists to
restore the local password backend on **Android**, where upstream replaced it
with Google Password Manager. Windows already ships a local password manager
upstream, so the patch has no meaning there. Reverting restores the stock
`#if !BUILDFLAG(IS_ANDROID)` guard, which is what a Windows build wants.

## Conflicts (not applied)

| Patch | Reason |
|---|---|
| 0122 enable-memory-tagging-in-all-processes | MTE is ARMv8.5 hardware tagging; no x64 equivalent |
| 0272 restore-local-backend-based-password-manager-setting | same Android local-backend work as 0266 |
| 0293 fixup-make-cross-origin-referrer-behavior-configurable | fixup for 0168, which needs the Vanadium tree scaffolding |

## Skipped deliberately

- **136 scaffolding patches** modify `vanadium/**`, a tree that only exists after
  the Vanadium build-system patches. Only meaningful for the Android APK build.
- **65 Android-only patches** touch nothing but Android paths.
- **20 build/resource patches** touch `BUILD.gn`, `*.gni`, `.grd`/`.grdp` or
  `.xml`. Deferred so the first compile could establish a working baseline;
  the substantive privacy changes are runtime source and were applied.
