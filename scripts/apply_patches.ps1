# Apply the ported Vanadium patch set to the fetched Chromium tree.
#
# Strategy: the patch series is sequential, so context for patch N often assumes
# patches 1..N-1 are already applied. Checking each patch against a clean tree
# (test_patches.ps1) therefore under-reports. Here we apply in order with a
# 3-way merge and classify each patch first:
#
#   android-only  every touched path is Android-scoped          -> skip
#   scaffolding   touches vanadium/** (tree created by patches) -> skip
#   build-file    touches BUILD.gn / *.gni / DEPS               -> defer, review by hand
#   port          runtime source only                           -> apply
param(
  [string]$Src    = "D:\chromium\src",
  [string]$PDir   = "D:\dsh_Workspaces\Daily\Vanadium\Vanadium-155.0.8059.84.0\patches",
  [string]$Report = "D:\chromium\apply_report.csv",
  [switch]$DryRun
)

$ErrorActionPreference = 'Continue'
Set-Location $Src

function Get-Category($paths) {
  if ($paths.Count -eq 0) { return 'empty' }
  if (@($paths | Where-Object { $_ -match '(^|/)vanadium/' }).Count -gt 0) { return 'scaffolding' }
  $nonAndroid = @($paths | Where-Object { $_ -notmatch 'android' })
  if ($nonAndroid.Count -eq 0) { return 'android-only' }
  if (@($nonAndroid | Where-Object {
        $_ -match '(^|/)(BUILD\.gn|DEPS)$' -or $_ -match '\.gni$' -or $_ -match '\.grdp?$' -or $_ -match '\.xml$'
      }).Count -gt 0) { return 'resources-or-build' }
  return 'port'
}

$rows = New-Object System.Collections.ArrayList
foreach ($f in (Get-ChildItem $PDir -Filter *.patch | Sort-Object Name)) {
  $text  = Get-Content $f.FullName -Raw
  $paths = @([regex]::Matches($text, 'diff --git a/([^ ]+)') | ForEach-Object { $_.Groups[1].Value })
  $cat   = Get-Category $paths

  if ($cat -ne 'port') {
    [void]$rows.Add([pscustomobject]@{ name=$f.Name; category=$cat; status='skipped'; detail='' })
    continue
  }

  $applyArgs = if ($DryRun) { @('apply','--check','--3way','--whitespace=nowarn',$f.FullName) }
               else         { @('apply','--3way','--whitespace=nowarn',$f.FullName) }
  $out  = & git @applyArgs 2>&1
  $code = $LASTEXITCODE
  [void]$rows.Add([pscustomobject]@{
    name     = $f.Name
    category = $cat
    status   = $(if ($code -eq 0) { if ($DryRun) {'applies'} else {'applied'} } else { 'CONFLICT' })
    detail   = ((($out | Out-String).Trim()) -replace "\r?\n", " | ")
  })
  if ($code -ne 0) { Write-Host ("CONFLICT  " + $f.Name) }
}

$rows | Export-Csv $Report -NoTypeInformation -Encoding UTF8
Write-Host ""
Write-Host "================ SUMMARY ================"
$rows | Group-Object category,status | ForEach-Object {
  Write-Host ("{0,-28} {1,4}" -f $_.Name, $_.Count)
}
Write-Host "report: $Report"
