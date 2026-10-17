# Install the Visual Studio 2022 C++ toolchain required by Chromium.
# Requires elevation; the host has ConsentPromptBehaviorAdmin=0 so RunAs is silent.
$vsargs = @(
  'modify',
  '--installPath', '"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"',
  '--add', 'Microsoft.VisualStudio.Workload.VCTools',
  '--add', 'Microsoft.VisualStudio.Component.VC.Tools.x86.x64',
  '--add', 'Microsoft.VisualStudio.Component.VC.ATLMFC',
  '--add', 'Microsoft.VisualStudio.Component.Windows11SDK.26100',
  '--includeRecommended',
  '--quiet',
  '--norestart'
)
$p = Start-Process -FilePath "C:\Program Files (x86)\Microsoft Visual Studio\Installer\setup.exe" `
     -ArgumentList $vsargs -Verb RunAs -Wait -PassThru
Write-Host "VS installer exit code: $($p.ExitCode)"

Write-Host "MSVC toolsets:"
Get-ChildItem "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC" -Directory |
  Select-Object -ExpandProperty Name
Write-Host "Windows SDKs:"
Get-ChildItem "C:\Program Files (x86)\Windows Kits\10\Include" -Directory |
  Select-Object -ExpandProperty Name
