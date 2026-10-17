# Configure and build the Windows x64 release browser.
param(
  [string]$Src   = "D:\chromium\src",
  [string]$Out   = "out\Release",
  [string]$Target = "chrome",
  [int]$Jobs     = 16
)

$env:PATH = "D:\chromium\depot_tools;" + $env:PATH
$env:DEPOT_TOOLS_WIN_TOOLCHAIN = "0"
$env:GYP_MSVS_VERSION = "2022"

Set-Location $Src
New-Item -ItemType Directory -Force -Path "$Src\$Out" | Out-Null
Copy-Item "..\args.gn" "$Src\$Out\args.gn" -Force -ErrorAction SilentlyContinue

& cmd /c "gn.bat gen $Out 2>&1"
if ($LASTEXITCODE -ne 0) { Write-Error "gn gen failed"; exit 1 }

& cmd /c "autoninja.bat -C $Out -j$Jobs $Target 2>&1"
Write-Host "build exit: $LASTEXITCODE"
