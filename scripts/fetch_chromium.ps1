# Fetch Chromium pinned to the revision Vanadium 155.0.8059.84 patches against.
param(
  [string]$Root     = "D:\chromium",
  [string]$Revision = "155.0.8059.84",
  [string]$Proxy    = "http://127.0.0.1:7897"
)

$ErrorActionPreference = 'Continue'
$env:HTTP_PROXY  = $Proxy
$env:HTTPS_PROXY = $Proxy
$env:NO_PROXY    = "localhost,127.0.0.1,::1"
# Use the locally installed Visual Studio instead of Google's internal toolchain.
$env:DEPOT_TOOLS_WIN_TOOLCHAIN = "0"
$env:GYP_MSVS_VERSION = "2022"

if (-not (Test-Path "$Root\depot_tools")) {
  git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git "$Root\depot_tools"
}

$env:PATH = "$Root\depot_tools;" + $env:PATH
Set-Location $Root

& cmd /c "$Root\depot_tools\gclient.bat sync --revision src@$Revision --no-history -j8 2>&1"
Write-Host "gclient sync exit: $LASTEXITCODE"
