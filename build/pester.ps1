#push-Location $PSScriptRoot\..\functions
$results = Invoke-Pester $psscriptroot\..\functions\*.ps1 -EnableExit -PassThru -Show all -OutputFile $psscriptroot\report.xml -OutputFormat NUnitXml -CodeCoverage $psscriptroot\..\functions\*.ps1
& "$PSScriptRoot\nunit\msxsl.exe" "$PSScriptRoot\report.xml" "$PSScriptRoot\nunit\nunit-to-junit.xsl" -o "$PSScriptRoot\..\junitreport.xml"
$failed = ($results.TestResult | Where-Object {$_.Passed -ne $true})
if ($failed) {
    $failed | Select-Object Context, Result, Name, Describe | Format-Table
    throw "Some rules failed."
}
#Pop-Location