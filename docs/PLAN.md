# Port plan

## Baseline

| | |
|---|---|
| Upstream | Chromium `155.0.8059.84` |
| Tag commit | `5869fe313571d75152b77813cf0a4ee26a4e6df0` |
| Target | Windows x64, official-style release build |
| Source of hardening | Vanadium `155.0.8059.84.0` (309 patches) |

Pinning to the **exact** upstream revision Vanadium patches against is what makes this
tractable: the privacy patches are single-line default flips with exact context, so
`git apply` succeeds without hand-editing.

## Patch triage

```
309 total
 ├─ 160  touch ONLY android-scoped paths      -> skipped (no Windows counterpart)
 ├─  76  touch android + shared paths         -> cherry-pick hunks touching shared paths
 └─  73  fully platform-independent           -> port directly
```

The 73 platform-independent patches are the substance of Vanadium's privacy hardening.
They land in shared Chromium code:

| Area | Files |
|---|---|
| Cookies | `components/content_settings/core/browser/cookie_settings.cc` |
| HTTPS | `chrome/browser/ui/browser_ui_prefs.cc` |
| Variations / field trials | `components/variations/**` |
| Network | `net/base/features.cc`, `services/network/public/cpp/features.cc` |
| Safe Browsing | `components/safe_browsing/core/common/safe_browsing_prefs.cc` |
| Password manager | `components/password_manager/core/browser/password_manager.cc` |
| Search | `components/search_engines/template_url_prepopulate_data.cc` |
| Origin isolation | `content/public/common/content_features.cc` |

## Android-only hardening → Windows approximation

Vanadium relies on GrapheneOS for several protections. Where Windows has a genuine
mechanism, an approximation is applied; where it does not, this is recorded honestly
rather than faked.

| Vanadium / GrapheneOS | Mechanism | Windows status |
|---|---|---|
| hardened malloc | OS-provided allocator hardening | **Partial** — Windows heap already has LFH/segment heap; no direct knob |
| seccomp-bpf dynamic-code restriction | kernel syscall filter | **Approximated** — Chromium's ACG / Arbitrary Code Guard on renderers, plus `--disable-features` for JIT where applicable |
| MTE (memory tagging) | ARMv8.5 hardware | **Not available** on x64 |
| CFI | `is_cfi` / `use_cfi_cast` | **Ported** — CFI is supported on Windows x64 |
| stack protector strong | `-fstack-protector-strong` | **Ported** — MSVC/clang-cl `/GS` (Chromium default) plus explicit flags |
| `-fwrapv`, auto-var-init | clang flags | **Ported** — clang-cl accepts them |
| stack clash protection | `-fstack-clash-protection` | arm64-only upstream; x64 has `/GS` stack probing |
| per-app JIT site settings UI | Android settings surface | **Approximated** — desktop equivalent under `chrome://settings/content` |
| WebView hardening | Android WebView | **N/A** — no WebView on Windows |

## Method

1. Fetch Chromium at the pinned tag.
2. `git apply --check` every patch to get an authoritative applicability list.
3. Apply the platform-independent set in upstream order; resolve conflicts.
4. For Android-only privacy semantics with a desktop counterpart, write an equivalent
   change against the desktop file (tracked in `patches/windows/`).
5. Build and verify.

## Verification

Each privacy default is checked against the built binary, not assumed:
- `chrome://version` for the exact revision
- `chrome://flags` / prefs for HTTPS-only mode, third-party cookies, field trials
- Absence of outbound requests to variations/safebrowsing/metrics endpoints
