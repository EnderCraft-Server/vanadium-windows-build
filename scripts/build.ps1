# Configure and build the Windows x64 release browser.
param(
  [string]$Src    = "D:\chromium\src",
  [string]$Out    = "out\Release",
  [string]$Target = "chrome",
  [int]$Jobs      = 16
)

$env:PATH = "D:\chromium\depot_tools;" + $env:PATH

# Use the locally installed Visual Studio rather than Google's packaged toolchain.
$env:DEPOT_TOOLS_WIN_TOOLCHAIN = "0"
$env:GYP_MSVS_VERSION = "2022"

# Chromium 155 looks for VS 2022 under %ProgramFiles%, but Visual Studio Build
# Tools installs under %ProgramFiles(x86)%. Without this override gn fails with
# "No supported Visual Studio can be found." Locate the install via vswhere and
# expose it as vs2022_install, which build/vs_toolchain.py checks first.
$vswhere = "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"
if (-not $env:vs2022_install -and (Test-Path $vswhere)) {
  $path = & $vswhere -latest -products * `
            -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
            -property installationPath
  if ($path) { $env:vs2022_install = $path.Trim() }
}
Write-Host "vs2022_install = $env:vs2022_install"
if (-not $env:vs2022_install) { Write-Error "No VS C++ toolchain found"; exit 1 }

Set-Location $Src
New-Item -ItemType Directory -Force -Path (Join-Path $Src $Out) | Out-Null
Copy-Item (Join-Path $PSScriptRoot "..\args.gn") (Join-Path $Src "$Out\args.gn") -Force

& cmd /c "gn.bat gen $Out 2>&1"
if ($LASTEXITCODE -ne 0) { Write-Error "gn gen failed"; exit 1 }

& cmd /c "autoninja.bat -C $Out -j$Jobs $Target 2>&1"
Write-Host "build exit: $LASTEXITCODE"
