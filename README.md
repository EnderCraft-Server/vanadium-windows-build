# Vanadium for Windows

A Windows x64 build of **Chromium 155.0.8059.84** with the platform-independent
privacy and security hardening from [Vanadium](https://github.com/GrapheneOS/Vanadium)
(GrapheneOS's hardened Chromium fork) ported over.

## Why this is a port and not a straight build

Vanadium is **Android-only**. Its build config targets `target_os = "android"` and ships
WebView + Trichrome APKs for GrapheneOS. Of its 309 patches:

| Category | Count | Windows |
|---|---|---|
| Touch only Android-scoped paths (WebView, APK targets, Java UI, Android permission model) | 160 | not portable |
| Reference Android somewhere | 236 | partially portable |
| Fully platform-independent | 73 | **ported** |

Vanadium's *security model* also leans on GrapheneOS itself — hardened malloc,
seccomp-bpf dynamic-code restriction, MTE, per-app JIT settings. Windows has no
equivalent for most of these; where a real counterpart exists it is approximated
(see `docs/PLAN.md`).

## What is preserved

The privacy/security defaults — the part that is genuinely platform-independent:

- HTTPS-only mode by default; HTTPS required for component updates
- Third-party cookies blocked by default
- No field trials / variations fetching, no seed-based trials, no variations header
- No metrics/reporting, no safe-browsing reporting, no component-updater pings
- Password leak detection disabled; Safety Hub disabled
- Network prediction, navigation error correction, hyperlink auditing off
- WebRTC IP handling at the most private policy
- Strict origin isolation, split cache, partitioned connections, reduced Accept-Language
- Sensors, payment, media router, background sync, translations, browser sign-in disabled
- DuckDuckGo as the default search engine
- Certificate Transparency enforced

## Building

See `docs/BUILD.md`.

## Status

See `PROGRESS.md` for the live build log.

## License

Chromium is BSD-3-Clause. Vanadium's patches are GPL-2.0. See `LICENSE` notes upstream.
