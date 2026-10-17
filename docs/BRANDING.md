# Branding: why it was Chromium, and what changed

## The miss

The first build reported itself as **Chromium**:

```
ProductName    : Chromium
FileDescription: Chromium
CompanyName    : The Chromium Authors
```

Cause: Vanadium's branding is carried by patches **0001/0002/0003**, which edit
`.grd`/`.grdp` string resources. The porting filter classified `.grd`/`.grdp`
files as "resources-or-build" and deferred all 20 such patches to establish a
working compile baseline first. The privacy patches were runtime source, so they
were applied; the branding patches were not. That was the intended sequencing, but
it meant the first artifact carried stock Chromium branding.

## What the branding patches actually are

| Patch | Files | Non-Android | Build files | Content |
|---|---|---|---|---|
| 0001 string rebranding, chrome layer | 574 | 335 | 0 | `.grd`/`.grdp` + `.xtb` translations |
| 0002 string rebranding, components layer | 644 | 404 | 0 | `.grd`/`.grdp` + `.xtb` translations |
| 0003 string rebranding, ui layer | 83 | 2 | 0 | `.grd` |
| 0004 Vanadium branding | 20 | **0** | 1 | Android icons/assets + config APK |
| 0005 branding for WebView | 1 | **0** | 0 | Android WebView |

0001-0003 are **pure string replacement** ("Chromium" -> "Vanadium") with zero
build-file changes, so they apply cleanly to a Windows tree. 0004 and 0005 touch
only Android paths (APK assets, WebView) and cannot affect a Windows build.

Result: 1301 files changed, **741 non-Android**.

## The piece the patches do not cover

The .grd patches fix every in-UI string, including `IDS_PRODUCT_NAME`:

```
chrome/app/chromium_strings.grd:297
  <message name="IDS_PRODUCT_NAME" desc="The Vanadium application name">
    Vanadium
```

But the **Windows PE version resource** does not read .grd. It is generated from
`chrome/app/chrome_version.rc.version`, whose `@COMPANY_FULLNAME@` and
`@PRODUCT_FULLNAME@` placeholders are filled from a BRANDING file through
`build/util/branding.gni`. No Vanadium patch touches that file, because Vanadium
ships only APKs, which have no PE version resource.

So it was rebranded directly:

```
chrome/app/theme/chromium/BRANDING

  COMPANY_FULLNAME=Vanadium
  COMPANY_SHORTNAME=Vanadium
  PRODUCT_FULLNAME=Vanadium
  PRODUCT_SHORTNAME=Vanadium
  PRODUCT_INSTALLER_FULLNAME=Vanadium Installer
  PRODUCT_INSTALLER_SHORTNAME=Vanadium Installer
  COPYRIGHT=Copyright @LASTCHANGE_YEAR@ Vanadium contributors. All rights reserved.
  MAC_BUNDLE_ID=app.vanadium.browser
```

`MAC_BUNDLE_ID` uses Vanadium's real Android package id, `app.vanadium.browser`.
It is inert on Windows.

## Verification

Version resource, after rebuild:

```
chrome.exe
  ProductName    : Vanadium
  FileDescription: Vanadium
  CompanyName    : Vanadium
  ProductVersion : 155.0.8059.84
  LegalCopyright : Copyright 2026 Vanadium contributors. All rights reserved.

chrome.dll
  ProductName    : Vanadium
  CompanyName    : Vanadium
```

End-to-end UI check, reading the real window title:

```
标题: [about:blank - Vanadium]
```

## What was deliberately not renamed

`chrome.exe` and `chrome.dll` keep their filenames. `chrome/common/chrome_constants.cc`
defines these as `kBrowserProcessExecutableName` and Chromium relies on them to
relaunch renderer and GPU child processes. Renaming the binaries would risk
breaking process spawning for a purely cosmetic gain, and nothing user-visible
reads the filename.

The user-data directory stays `%LOCALAPPDATA%\Chromium\User Data` for the same
reason: it is a profile path, not a product name, and changing it would orphan
existing profiles.

Note that `.pak` resources are a compressed binary format, so `grep`ping a built
`.pak` for "Vanadium" returns nothing even when the string is present. The window
title check above is the reliable test.
