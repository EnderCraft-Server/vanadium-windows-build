# Vanadium patch inventory (309 patches)

Generated from the Vanadium 155.0.8059.84.0 patch set. Category is derived from the
file paths each patch touches:

- **platform-independent** - no file path is Android-scoped; portable to Windows directly
- **mixed** - touches both Android and shared paths; shared hunks may be cherry-picked
- **android-only** - every file is Android-scoped; cannot affect a Windows build

| # | Patch | Category | Files |
|---|---|---|---|
| 0001 | Vanadium string rebranding at chrome layer | mixed | 574 |
| 0002 | Vanadium string rebranding at components layer | mixed | 644 |
| 0003 | Vanadium string rebranding at ui layer | mixed | 83 |
| 0004 | Vanadium branding | android-only | 20 |
| 0005 | Vanadium branding for WebView | android-only | 1 |
| 0006 | Support for extended version name and increments | mixed | 3 |
| 0007 | temporary Workaround for crashes at StackTrace calls | platform-independent | 1 |
| 0008 | use 64 bit WebView processes | android-only | 1 |
| 0009 | add support for appending build flags for Vanadium | platform-independent | 2 |
| 0010 | enable stack clash protection for arm64 targets | platform-independent | 1 |
| 0011 | switch to fstack protector strong | platform-independent | 1 |
| 0012 | enable fwrapv in Clang for non UBSan builds | platform-independent | 1 |
| 0013 | enable ftrivial auto var init zero | platform-independent | 1 |
| 0014 | disable broken warning for auto var init | platform-independent | 1 |
| 0015 | Only enable shadow_call_stack on android arm64 targe | platform-independent | 1 |
| 0016 | Use fstack protector strong with shadow call stack w | platform-independent | 1 |
| 0017 | prepare for adding modifying site settings downstrea | platform-independent | 1 |
| 0018 | disable unused histogram checks for adding site sett | platform-independent | 2 |
| 0019 | add trichrome browser apk targets | android-only | 2 |
| 0020 | Fix versionCode for 64 bit only builds | platform-independent | 1 |
| 0021 | bugfix searchbox avoid compiling non android code | platform-independent | 1 |
| 0022 | bugfix omnibox avoid compiling non android code | platform-independent | 1 |
| 0023 | bugfix Fix chrome target generation when secondary A | android-only | 1 |
| 0024 | bugfix Fix builds without secondary abis when using  | platform-independent | 1 |
| 0025 | bugfix Resolve chrome browser core deps when dfmify_ | platform-independent | 1 |
| 0026 | Extend android webview glue_java target sources and  | android-only | 3 |
| 0027 | downstream string additions for chrome specific brow | android-only | 2 |
| 0028 | Extend android_webview java targets sources and deps | android-only | 5 |
| 0029 | Extend android_webview browser cc target sources and | android-only | 3 |
| 0030 | Extend android_webview renderer cc target sources an | android-only | 3 |
| 0031 | Extend android_webview common cc target sources and  | android-only | 3 |
| 0032 | Extend base java targets sources and deps | platform-independent | 10 |
| 0033 | Support rm of base library loader java target source | platform-independent | 4 |
| 0034 | Extend chrome android java group target deps | android-only | 2 |
| 0035 | Extend chrome android java targets sources and deps | android-only | 5 |
| 0036 | Extend chrome browser autofill android java target s | android-only | 5 |
| 0037 | Extend chrome browser language android java target d | android-only | 3 |
| 0038 | Extend chrome browser ui android pdf java target sou | android-only | 3 |
| 0039 | Extend content public android java target sources an | android-only | 3 |
| 0040 | Extend content renderer cc targets sources and deps | platform-independent | 3 |
| 0041 | Extend components page_info android java target sour | android-only | 3 |
| 0042 | Extend components permissions android java target so | android-only | 3 |
| 0043 | Extend components subresource_filter android java an | android-only | 6 |
| 0044 | Extend components variations cc target sources and d | platform-independent | 3 |
| 0045 | Extend components variations services cc target sour | platform-independent | 3 |
| 0046 | Extend content public android java group target deps | android-only | 2 |
| 0047 | Extend content public common cc target sources and d | platform-independent | 3 |
| 0048 | Extend chrome browser android cc target sources and  | android-only | 3 |
| 0049 | Extend chrome browser net cc target sources and deps | platform-independent | 5 |
| 0050 | Extend chrome browser component_updater cc targets s | platform-independent | 5 |
| 0051 | Extend net dns cc target sources and deps | platform-independent | 3 |
| 0052 | Extend android_webview test java target sources and  | android-only | 3 |
| 0053 | Extend sandbox policy linux cc targets sources and d | platform-independent | 3 |
| 0054 | Extension of feature fetching for android_webview co | android-only | 8 |
| 0055 | Extension of feature fetching for chrome browser fla | android-only | 8 |
| 0056 | Extension of feature fetching for content public and | mixed | 8 |
| 0057 | Extension of feature declaration for components brow | android-only | 4 |
| 0058 | Support for extending strings for modified added sit | android-only | 2 |
| 0059 | more extended strings for modified added site settin | platform-independent | 3 |
| 0060 | Extend site site settings UI java target sources and | android-only | 4 |
| 0061 | Add preference key for permission category types for | android-only | 1 |
| 0062 | Initial support for hooking site settings UI changes | android-only | 16 |
| 0063 | disable first run welcome page | android-only | 1 |
| 0064 | java and cpp files for fetching fieldtrial seed vari | mixed | 2 |
| 0065 | disable seed based field trials | platform-independent | 6 |
| 0066 | disable fetching variations | android-only | 2 |
| 0067 | disable WebView variations support | android-only | 4 |
| 0068 | disable Media Integrity blink extension API on webvi | android-only | 11 |
| 0069 | disable navigation error correction by default | platform-independent | 1 |
| 0070 | disable contextual search by default | mixed | 2 |
| 0071 | disable network prediction by default | platform-independent | 1 |
| 0072 | disable metrics by default | android-only | 1 |
| 0073 | disable hyperlink auditing by default | platform-independent | 1 |
| 0074 | disable showing popular sites by default | platform-independent | 2 |
| 0075 | disable article suggestions feature by default | platform-independent | 1 |
| 0076 | disable content feed suggestions by default | platform-independent | 1 |
| 0077 | disable sensors access by default | platform-independent | 1 |
| 0078 | ask before playing protected media by default | platform-independent | 1 |
| 0079 | disable third party cookies by default | platform-independent | 1 |
| 0080 | disable background sync by default | platform-independent | 1 |
| 0081 | disable payment support by default | platform-independent | 1 |
| 0082 | disable media router media remoting by default | platform-independent | 1 |
| 0083 | disable media router by default | platform-independent | 2 |
| 0084 | disable offering translations by default | platform-independent | 1 |
| 0085 | disable browser sign in feature by default | platform-independent | 2 |
| 0086 | disable safe browsing reporting opt in by default | platform-independent | 1 |
| 0087 | disable unused safe browsing option by default | platform-independent | 1 |
| 0088 | disable media DRM preprovisioning by default | platform-independent | 1 |
| 0089 | disable autofill server communication by default | platform-independent | 1 |
| 0090 | disable component updater pings by default | platform-independent | 1 |
| 0091 | disable search provider logo | android-only | 1 |
| 0092 | disable trivial subdomain hiding | platform-independent | 1 |
| 0093 | disable learn more link in incognito new tab | android-only | 1 |
| 0094 | disable Omaha update check support | android-only | 2 |
| 0095 | disable GaiaAuthFetcher code due to upstream bug | platform-independent | 1 |
| 0096 | Disable adding a signed out avatar on new tab pages  | android-only | 2 |
| 0097 | Disable newer privacy sandbox features by default | platform-independent | 3 |
| 0098 | Disable WebGPU in Android by default | platform-independent | 1 |
| 0099 | Disable top toolbar button Translate option by defau | android-only | 1 |
| 0100 | always use local new tab page | platform-independent | 1 |
| 0101 | mark non secure origins as dangerous | platform-independent | 1 |
| 0102 | most private WebRTC IP handling policy by default | platform-independent | 1 |
| 0103 | stub out the battery status API | platform-independent | 1 |
| 0104 | stop ignoring download location prompt setting | android-only | 1 |
| 0105 | show download prompt again by default | android-only | 1 |
| 0106 | disable trials of privacy aware analytics advertisin | platform-independent | 1 |
| 0107 | disable using Play services fonts | android-only | 1 |
| 0108 | disable appending variations header | platform-independent | 1 |
| 0109 | Disable detailed language settings by default | platform-independent | 1 |
| 0110 | disable fetching optimization guides by default | platform-independent | 1 |
| 0111 | Disable tab group sync settings UI by default | android-only | 7 |
| 0112 | disable fetching optimization hints by default | platform-independent | 1 |
| 0113 | disable more optimization guides features by default | platform-independent | 4 |
| 0114 | disable network time tracker by default | platform-independent | 1 |
| 0115 | Disable opening PDF in the app by default | android-only | 7 |
| 0116 | Disable Glic features by default | platform-independent | 1 |
| 0117 | set default search engine to DuckDuckGo | platform-independent | 1 |
| 0118 | set original package to org.chromium.chrome | android-only | 1 |
| 0119 | Make HTTPS only mode the default | platform-independent | 1 |
| 0120 | require HTTPS for component updates | platform-independent | 1 |
| 0121 | use vanadium.app for component updates | mixed | 3 |
| 0122 | enable memory tagging in all processes | mixed | 2 |
| 0123 | enable split cache by default | platform-independent | 1 |
| 0124 | enable partitioning connections by default | platform-independent | 1 |
| 0125 | enable dubious Do Not Track feature by default | platform-independent | 1 |
| 0126 | enable strict site isolation by default on Android | platform-independent | 2 |
| 0127 | Enable strict origin isolation by default | platform-independent | 1 |
| 0128 | Enable reduce accept language header by default | platform-independent | 1 |
| 0129 | use Google Chrome branding for client hints | platform-independent | 1 |
| 0130 | Remove logo from chrome version | platform-independent | 1 |
| 0131 | redirect settings help icon | android-only | 2 |
| 0132 | remove Google prefix from storage settings label | android-only | 1 |
| 0133 | remove Help feedback menu entry | android-only | 1 |
| 0134 | bugfix add missing null check for updating preferenc | android-only | 1 |
| 0135 | Utility class for adding shared preference keys | mixed | 3 |
| 0136 | Helper class for modifying preferences | android-only | 2 |
| 0137 | Remove not applicable additional terms of services | android-only | 1 |
| 0138 | remove Google terms of use and privacy policy | android-only | 1 |
| 0139 | Hide Sign In preference when disallowed | android-only | 1 |
| 0140 | Hide currently no op preload settings | android-only | 1 |
| 0141 | remove safety check menu | android-only | 1 |
| 0142 | remove unwanted account and services section | android-only | 1 |
| 0143 | Utility class for modifying preferences at Privacy s | android-only | 6 |
| 0144 | Make PrivacySettings preference keys declaration pac | android-only | 1 |
| 0145 | remove unwanted sync and services link | android-only | 1 |
| 0146 | Utility class of language settings for modification | android-only | 4 |
| 0147 | remove translate offer preference | android-only | 1 |
| 0148 | Remove privacy guides preference UI | android-only | 1 |
| 0149 | Move search suggestions back to privacy section | android-only | 2 |
| 0150 | Remove javascript optimizer settings UI | android-only | 1 |
| 0151 | Disable default browser promotion features by defaul | android-only | 2 |
| 0152 | Remove javascript optimizer settings UI link on Priv | android-only | 1 |
| 0153 | Hide potentially no op password leak detection toggl | android-only | 1 |
| 0154 | Toggle for closing tabs on exit | android-only | 7 |
| 0155 | Toggle for opening external links in incognito tabs | android-only | 9 |
| 0156 | Handle more web search intents in browser | android-only | 3 |
| 0157 | Support opening external web search in incognito | android-only | 3 |
| 0158 | Apply toggle for opening links in incognito for cust | android-only | 2 |
| 0159 | Apply toggle for opening links in incognito for sear | android-only | 4 |
| 0160 | Apply toggle for opening links in incognito for shar | android-only | 2 |
| 0161 | Derive high entropy client hints with reduced user a | platform-independent | 4 |
| 0162 | Add missing null check for password manager autofill | platform-independent | 1 |
| 0163 | Drop workaround with android autofill in compatibili | android-only | 1 |
| 0164 | Enable usage of Android Autofill by default | platform-independent | 1 |
| 0165 | Disable Play services dependent password manager pre | platform-independent | 1 |
| 0166 | Use local list of supported languages for Language s | platform-independent | 1 |
| 0167 | Implement UI for WebRTC toggle | android-only | 10 |
| 0168 | make cross origin referrer behavior configurable | mixed | 30 |
| 0169 | Add an easily extensible way to reference targets ea | platform-independent | 2 |
| 0170 | Support extension of kotlin files allowlist for comp | android-only | 2 |
| 0171 | Common target for config app generation and parsing | android-only | 2 |
| 0172 | Include a java port of atomic file and scoped file d | platform-independent | 3 |
| 0173 | Utility class for caching members to invoke via refl | platform-independent | 2 |
| 0174 | Utility class for initializing system feature info c | platform-independent | 2 |
| 0175 | Methods for calling custom OS APIs | platform-independent | 2 |
| 0176 | class for fetching custom OS permissions existence a | platform-independent | 2 |
| 0177 | Add a new config like apk target for building | android-only | 4 |
| 0178 | config Directly reference config apk build target | mixed | 2 |
| 0179 | config Generate ConfigInfo from config apk | android-only | 2 |
| 0180 | config Provide targets for linking and inclusion of  | android-only | 1 |
| 0181 | config Add proto definitions for feature flags and o | android-only | 2 |
| 0182 | config Add protobuf generator parser for config apk  | android-only | 5 |
| 0183 | config parser Add config parser for browser and webv | android-only | 4 |
| 0184 | filter lists .gitignore file for downloaded files | android-only | 1 |
| 0185 | config Build target for android assets including the | android-only | 2 |
| 0186 | config Build target for android assets for config fi | android-only | 1 |
| 0187 | config Add the needed component and protobuf file fo | android-only | 1 |
| 0188 | Add extension for android build rules for compiling  | android-only | 2 |
| 0189 | Add config apk build info for apk targets with dex | android-only | 1 |
| 0190 | Add hooks for applying flags features at runtime | android-only | 2 |
| 0191 | Redeclare library loader java enums as android libra | platform-independent | 3 |
| 0192 | Hooks for LibraryLoader early init and command line  | mixed | 4 |
| 0193 | Hooks for initializing Vanadium configs including vi | android-only | 2 |
| 0194 | Initialize configs from config app on library loadin | android-only | 2 |
| 0195 | Expose fetching config state for content filtering t | android-only | 5 |
| 0196 | Use ruleset from config apk whenever it s present | mixed | 3 |
| 0197 | content filtering Add update handling of subresource | android-only | 5 |
| 0198 | Update subresource filter from config apk | android-only | 2 |
| 0199 | Use the content filtering from config app when avail | platform-independent | 3 |
| 0200 | Add VanadiumConfig version on about Vanadium setting | android-only | 2 |
| 0201 | don t show subresource filter UI for site | platform-independent | 1 |
| 0202 | enable subresource filter on all sites | platform-independent | 2 |
| 0203 | Use the old naming convention of Ads in ads site set | mixed | 6 |
| 0204 | enable wasm in JITless mode when per site JIT is dis | platform-independent | 1 |
| 0205 | revert upstream Revert clearing javascript JIT site  | platform-independent | 2 |
| 0206 | Modify command lines needed for isolated services | android-only | 4 |
| 0207 | net layer for fetching OS connectivity check setting | android-only | 9 |
| 0208 | Respect connectivity check setting on DNS over HTTPS | platform-independent | 3 |
| 0209 | Respect connectivity check setting on dns_probe_runn | platform-independent | 3 |
| 0210 | Respect connectivity check setting on browser connec | android-only | 2 |
| 0211 | Respect connectivity check setting on when to run go | platform-independent | 1 |
| 0212 | add zxing core library build target for barcode scan | platform-independent | 2 |
| 0213 | service layer for downstream impl usage of shape det | android-only | 8 |
| 0214 | support redirecting barcode detection to downstream  | mixed | 2 |
| 0215 | support redirecting text detection to downstream imp | android-only | 1 |
| 0216 | Implement UI for JIT site settings | mixed | 12 |
| 0217 | Enable CredentialManager APIs for all apps supportin | android-only | 2 |
| 0218 | Revert Fixit Update Password Manager to Google Passw | android-only | 2 |
| 0219 | Match skipping compatibility check default value che | mixed | 4 |
| 0220 | Set Toolbar shortcut default to new tab instead of a | android-only | 1 |
| 0221 | Add a method to hook at Application.attachBaseContex | android-only | 2 |
| 0222 | Add hooks for ChromeApplicationImpl to initialize co | android-only | 3 |
| 0223 | content filtering Add support for updating content f | android-only | 3 |
| 0224 | Add support for conditional content filtering compon | android-only | 2 |
| 0225 | add support for other language content filtering dep | android-only | 1 |
| 0226 | Allow usage of blink headers in vanadium chromium_sr | platform-independent | 1 |
| 0227 | Add feature flag for stubbed safe browsing callback  | android-only | 5 |
| 0228 | Support restriction of dynamic code | platform-independent | 2 |
| 0229 | Restriction of dynamic code execution via seccomp bp | mixed | 16 |
| 0230 | config Explicitly declare queries to config package  | android-only | 4 |
| 0231 | config Compile the config holder app with forceQuery | android-only | 2 |
| 0232 | tmp Disable Safety Hub features by default | platform-independent | 2 |
| 0233 | Enable HSTS upgrades for top level navigation only b | platform-independent | 1 |
| 0234 | Reduce user agent and client hints for webview | android-only | 3 |
| 0235 | remove upstream code disabling WebView MTE | android-only | 1 |
| 0236 | remove debug dump when MTE is disabled | platform-independent | 1 |
| 0237 | Reset saved javascript optimizer site setting | platform-independent | 2 |
| 0238 | Support for extra arguments declared for chrome laye | android-only | 1 |
| 0239 | Support for excluding crashpad in compiling chrome t | android-only | 3 |
| 0240 | Always allow platform CredentialManager calls for An | android-only | 2 |
| 0241 | Increment minSdk to 34 trichrome apk build targets | android-only | 3 |
| 0242 | Disable password leak detection by default | platform-independent | 1 |
| 0243 | Further disable password leak detection checks | platform-independent | 1 |
| 0244 | enable certificate transparency feature by default f | platform-independent | 1 |
| 0245 | enable more Local Network Access coverage checks by  | platform-independent | 1 |
| 0246 | hide and don t fetch icons for search engine setting | android-only | 1 |
| 0247 | bugfix update arm64 TrichromeLibrary AndroidManifest | android-only | 1 |
| 0248 | bugfix update TrichromeLibrary AndroidManifest expec | android-only | 2 |
| 0249 | bugfix Add x64 TrichromeLibrary AndroidManifest expe | android-only | 1 |
| 0250 | Enable origin keyed process isolation by default | platform-independent | 1 |
| 0251 | Allow registration of passkeys regardless of residen | android-only | 1 |
| 0252 | disable misleading new tab cards by default | android-only | 1 |
| 0253 | disable additional buttons below search bar in new t | android-only | 1 |
| 0254 | Apply toggle for opening links in incognito for expl | android-only | 3 |
| 0255 | remove unused separate autofill status | android-only | 1 |
| 0256 | always enable autofill screens regardless of autofil | mixed | 18 |
| 0257 | Initial support for toggling Sensors site settings p | android-only | 5 |
| 0258 | component layer specific for components permission a | android-only | 2 |
| 0259 | infrastructure permission modification based on cont | android-only | 6 |
| 0260 | Reflect Javascript JIT site settings on page info ba | android-only | 3 |
| 0261 | Reflect Motion Sensors based on OS permission in pag | android-only | 3 |
| 0262 | Reflect changes for removed settings in search | android-only | 3 |
| 0263 | Revert removal of database for local password manage | platform-independent | 1 |
| 0264 | Restore build args of using login database as backen | platform-independent | 1 |
| 0265 | Restore buildflag for using login database as backen | platform-independent | 1 |
| 0266 | Restore file name refs for password manager local da | platform-independent | 2 |
| 0267 | Restore necessary prefs for local backend password m | platform-independent | 2 |
| 0268 | Restore support of login database backend for Androi | platform-independent | 7 |
| 0269 | Revert passwords android Move reduce visibility of s | android-only | 16 |
| 0270 | Restore chrome browser password_entry_edit for local | mixed | 51 |
| 0271 | Restore local password manager UI | mixed | 36 |
| 0272 | restore local backend based password manager setting | mixed | 5 |
| 0273 | Partially revert changes on UserActionableError enum | platform-independent | 7 |
| 0274 | import and export bookmarks feature | mixed | 22 |
| 0275 | Increment top search engine threshold to 7 | platform-independent | 1 |
| 0276 | Start child processes in JITless mode based on OS co | android-only | 2 |
| 0277 | Fix building tests with enable_reporting false in bu | platform-independent | 1 |
| 0278 | Update Resources and Configuration generated protobu | android-only | 2 |
| 0279 | Document more needed removals for protobuf | android-only | 1 |
| 0280 | Disable predictive back gesture for Vanadium | android-only | 1 |
| 0281 | Enable WebViewFasterGetDefaultUserAgent by default | android-only | 2 |
| 0282 | Use non empty NetworkAnonymizationKey for WebView pr | android-only | 1 |
| 0283 | Include ACCESS_LOCAL_NETWORK to uses permission guar | android-only | 3 |
| 0284 | Partially revert upstream M152 LNP Require ACCESS_LO | android-only | 1 |
| 0285 | tmp Disable workaround for Imagination vendor GPU fo | platform-independent | 1 |
| 0286 | tmp use gl_version 3.2 for gl_clear_broken Imaginati | platform-independent | 1 |
| 0287 | upstream Reapply WV Separate notifyChromiumStarted f | android-only | 2 |
| 0288 | upstream Reapply Reland Make setWebViewClient not tr | android-only | 1 |
| 0289 | upstream Reapply wv Make checkNeedsPost check for mA | android-only | 1 |
| 0290 | Disable new tab appearance customization feature by  | mixed | 2 |
| 0291 | bugfix Avoid unneeded calls to clipboard primary con | android-only | 3 |
| 0292 | bugfix Avoid resetting IME state on window focus los | android-only | 1 |
| 0293 | fixup make cross origin referrer behavior configurab | platform-independent | 1 |
| 0294 | config Add baseline components and flag configs for  | android-only | 1 |
| 0295 | config Enable stubbed safe browsing callback for Web | android-only | 1 |
| 0296 | Extend chrome android base_module_java targets sourc | android-only | 3 |
| 0297 | Earlier config app parsing and feature list init on  | android-only | 4 |
| 0298 | Check config app feature flags set on webview cached | android-only | 4 |
| 0299 | Earlier WebView config parsing and feature list init | android-only | 4 |
| 0300 | fixup Initialize configs from config app on library  | android-only | 1 |
| 0301 | Allow MADV_DONTNEED_LOCKED needed with hardened mall | platform-independent | 1 |
| 0302 | config Disable new tab appearance customization feat | android-only | 1 |
| 0303 | Revert bugfix Fix chrome target generation when seco | android-only | 1 |
| 0304 | Revert add trichrome browser apk targets | android-only | 2 |
| 0305 | bugfix Fix chrome target generation when secondary A | android-only | 1 |
| 0306 | Add needed visibility allowlist for custom browser a | platform-independent | 1 |
| 0307 | Add dedicated browser target for Vanadium | mixed | 2 |
| 0308 | Add dedicated webview target for Vanadium | mixed | 2 |
| 0309 | bugfix Only log soft navigation heuristic metrics | platform-independent | 1 |

## Totals

| Category | Count |
|---|---|
| platform-independent | 122 |
| mixed | 27 |
| android-only | 160 |
| **total** | **309** |
