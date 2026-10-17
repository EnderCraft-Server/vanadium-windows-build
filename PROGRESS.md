# Progress log

## 2026-10-17 — build complete

**Chromium 155.0.8059.84 for Windows x64, with 85 Vanadium privacy/security
patches applied, compiles and runs.**

```
1h5m04.48s Build Succeeded: 9254 steps
chrome.exe  3.8 MB    ProductVersion 155.0.8059.84
chrome.dll  328.4 MB
```

Verified: 16/16 privacy defaults confirmed in the built tree; browser launches
and renders HTML from the standalone package.

- Full timeline and every blocker: `docs/BUILD_REPORT.md`
- Verification evidence: `docs/VERIFICATION.md`
- Host fixes: `docs/ENVIRONMENT_FIXES.md`
- CFI decision: `docs/CFI_DECISION.md`
- Patch triage: `docs/PATCH_INVENTORY.md`, `docs/PATCH_DEVIATIONS.md`

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
