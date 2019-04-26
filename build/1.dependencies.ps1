if (!(Get-Module -listavailable | ? {$_.Name -eq 'Pester'})) {Install-Module pester -force}
if (!(Get-Module -listavailable | ? {$_.Name -eq 'PSDepend'})) {Install-Module PSDepend -force}
if (!(Get-Module -listavailable | ? {$_.Name -eq 'buildhelpers'})) {Install-Module buildhelpers -force}
if (!(Get-Module -listavailable | ? {$_.Name -eq 'PSScriptAnalyzer'})) {Install-Module PSScriptAnalyzer -force}
if (!(Get-Module -listavailable | ? {$_.Name -eq 'psake'})) {Install-Module psake -force}
if (!(Get-Module -listavailable | ? {$_.Name -eq 'PlatyPS'})) {Install-Module PlatyPS -force}
#Start-Process msiexec.exe -ArgumentList "/i $($psscriptroot)\resources\microsoftazurestorageemulator.msi /qn" -Wait