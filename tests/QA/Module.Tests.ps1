$here = $PSScriptRoot
$modulePath = Join-Path -Path $PSScriptRoot -ChildPath ..\..\output\JeaDsc
$psd1 = Import-PowerShellDataFile -Path $ModuleManifestPath

Describe 'Testing Module Manifest' -Tag 'ModuleManifest' {

    It "Does not contain key 'CmdletsToExport'" {
        $psd1.ContainsKey('CmdletsToExport') | Should Be $false
    }

    It "Does contain key 'DscResourcesToExport'" {
        $psd1.ContainsKey('DscResourcesToExport') | Should Be $true
    }

}
