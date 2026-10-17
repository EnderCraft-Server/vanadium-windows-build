# Verification

## Build

```
1h5m04.48s Build Succeeded: 9254 steps
```

| Artifact | Size |
|---|---|
| `chrome.exe` | 3.8 MB |
| `chrome.dll` | 328.4 MB |
| Distribution package | 539.7 MB |

```
ProductName    : Chromium
FileDescription: Chromium
ProductVersion : 155.0.8059.84
FileVersion    : 155.0.8059.84
CompanyName    : The Chromium Authors
```

## Runtime

Executed from the packaged distribution directory, standalone:

```
$ chrome.exe --headless=new --disable-gpu --user-data-dir=... --dump-dom about:blank
<html><head></head><body></body></html>

$ chrome.exe --headless=new --disable-gpu --user-data-dir=... --dump-dom \
    "data:text/html,<h1>Vanadium Windows</h1><p>ok</p>"
<html><head></head><body><h1>Vanadium Windows</h1><p>ok</p></body></html>
```

The browser starts, spawns its renderer, and renders HTML correctly.

## Privacy defaults

Checked against the exact source tree that produced the binary. These are
compile-time pref/feature registration literals, so the built binary carries them
by construction.

| Setting | Source | Present |
|---|---|---|
| Third-party cookies blocked (`kBlockThirdParty`) | `components/content_settings/core/browser/cookie_settings.cc` | yes |
| HTTPS-only mode on by default | `chrome/browser/ui/browser_ui_prefs.cc` | yes |
| WebRTC IP handling at most private policy | `chrome/browser/ui/browser_ui_prefs.cc` | yes |
| Split cache enabled | `net/base/features.cc` | yes |
| Partitioned connections enabled | `net/base/features.cc` | yes |
| Strict origin isolation | `content/public/common/content_features.cc` | yes |
| Reduced Accept-Language | `services/network/public/cpp/features.cc` | yes |
| Password leak detection disabled | `components/password_manager/core/browser/password_manager.cc` | yes |
| No variations header | `components/variations/net/variations_http_headers.cc` | yes |
| Safety Hub disabled | `components/safety_check/features.cc` | yes |
| DuckDuckGo default search engine | `components/search_engines/template_url_prepopulate_data.cc` | yes |
| Safe Browsing disabled + reporting opt-in disallowed | `components/safe_browsing/core/common/safe_browsing_prefs.cc` | yes |
| Autofill server communication off | `components/autofill/core/common/autofill_debug_features.cc` | yes |
| Optimization guide/hints off | `components/optimization_guide/core/optimization_guide_features.cc` | yes |
| Newer Privacy Sandbox features off | `components/privacy_sandbox/privacy_sandbox_prefs.cc` | yes |
| Subresource filter on all sites | `components/subresource_filter/core/browser/subresource_filter_features.cc` | yes |

**16 / 16 confirmed.**

Note on method: pref defaults are not written to the on-disk `Preferences` file
until a user changes them, so inspecting a fresh profile shows them as absent
rather than as their default values. Chrome's `chrome://prefs-internals` reports
live values but does not navigate under `--headless` in this build. Verifying the
registration literals in the built tree is therefore the accurate check.

## Build-time privacy config (`args.gn`)

```
enable_reporting = false                 # no reporting/crash-upload stack
disable_fieldtrial_testing_config = true # no field trial test config baked in
enable_vr = false
enable_remoting = false
```

## Honest gaps

See `docs/PLAN.md` for the full Android-to-Windows matrix. In short:

- **MTE** (memory tagging) has no x64 equivalent — not available.
- **seccomp-bpf** dynamic-code restriction is Linux-only; Windows CFG/ACG are the
  closest analogues and are already in play.
- **GrapheneOS hardened malloc** has no direct Windows knob.
- **Clang CFI** is disabled, see `docs/CFI_DECISION.md`. Windows Control Flow
  Guard (`/guard:cf`) remains enabled.
- Vanadium's **Android UI surfaces** (WebView, per-app JIT site settings) do not
  exist on Windows.
