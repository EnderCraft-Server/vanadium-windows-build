# Dry-run every Vanadium patch against the fetched tree.
# Produces patch_check.csv with an authoritative applicability list.
param(
  [string]$Src    = "D:\chromium\src",
  [string]$PDir   = "D:\dsh_Workspaces\Daily\Vanadium\Vanadium-155.0.8059.84.0\patches",
  [string]$Report = "D:\chromium\patch_check.csv"
)
Set-Location $Src
$rows = New-Object System.Collections.ArrayList
foreach ($f in (Get-ChildItem $PDir -Filter *.patch | Sort-Object Name)) {
  $out = & git apply --check --whitespace=nowarn $f.FullName 2>&1
  $ok  = ($LASTEXITCODE -eq 0)
  [void]$rows.Add([pscustomobject]@{
    name = $f.Name
    ok   = $ok
    err  = ((($out | Out-String).Trim()) -replace "?
", " | ")
  })
}
$rows | Export-Csv $Report -NoTypeInformation -Encoding UTF8
$good = @($rows | Where-Object { $_.ok })
Write-Host "APPLICABLE CLEANLY: $($good.Count) / $($rows.Count)"
$good | ForEach-Object { Write-Host ("  OK    " + $_.name) }
