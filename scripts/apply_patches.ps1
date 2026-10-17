# Apply the ported Vanadium patch set to the fetched Chromium tree.
#
# Classification: a patch is skipped when every file it touches is Android-scoped
# (chrome/android/**, **/*android*, WebView, APK targets). Those cannot affect a
# Windows build. Everything else is applied with a 3-way merge and logged.
param(
  [string]$Src    = "D:\chromium\src",
  [string]$PDir   = "D:\dsh_Workspaces\Daily\Vanadium\Vanadium-155.0.8059.84.0\patches",
  [string]$Report = "D:\chromium\apply_report.csv",
  [switch]$DryRun
)

$ErrorActionPreference = 'Continue'
Set-Location $Src

$rows = New-Object System.Collections.ArrayList
foreach ($f in (Get-ChildItem $PDir -Filter *.patch | Sort-Object Name)) {
  $text  = Get-Content $f.FullName -Raw
  $paths = [regex]::Matches($text, 'diff --git a/([^ ]+)') | ForEach-Object { $_.Groups[1].Value }

  $androidOnly = ($paths.Count -gt 0) -and (@($paths | Where-Object { $_ -notmatch 'android' }).Count -eq 0)
  if ($androidOnly) {
    [void]$rows.Add([pscustomobject]@{ name=$f.Name; status='skipped-android'; detail='' })
    continue
  }

  if ($DryRun) {
    $out = & git apply --check --3way --whitespace=nowarn $f.FullName 2>&1
    [void]$rows.Add([pscustomobject]@{
      name   = $f.Name
      status = $(if ($LASTEXITCODE -eq 0) { 'applies' } else { 'conflict' })
      detail = ((($out | Out-String).Trim()) -replace "?
"," | ")
    })
    continue
  }

  $out = & git apply --3way --whitespace=nowarn $f.FullName 2>&1
  $code = $LASTEXITCODE
  [void]$rows.Add([pscustomobject]@{
    name   = $f.Name
    status = $(if ($code -eq 0) { 'applied' } else { 'FAILED' })
    detail = ((($out | Out-String).Trim()) -replace "?
"," | ")
  })
  if ($code -ne 0) { Write-Warning "failed: $($f.Name)" }
}

$rows | Export-Csv $Report -NoTypeInformation -Encoding UTF8
Write-Host ""
Write-Host "applied  : $(@($rows | Where-Object status -eq 'applied').Count)"
Write-Host "conflict : $(@($rows | Where-Object status -eq 'conflict').Count)"
Write-Host "failed   : $(@($rows | Where-Object status -eq 'FAILED').Count)"
Write-Host "skipped  : $(@($rows | Where-Object status -eq 'skipped-android').Count)"
Write-Host "report   : $Report"
