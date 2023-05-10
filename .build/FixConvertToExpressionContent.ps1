task FixConvertToExpressionContent {

    $filePath = Join-Path -Path $SourcePath -ChildPath 'Modules\ConvertToExpression\ConvertToExpression.psm1'

    $fileContent = Get-Content -Path $filePath -Raw
    $fileContent = $fileContent.Replace('using namespace System.Management.Automation', '')
    $fileContent = $fileContent.Replace('PSMethod', 'System.Management.Automation.PSMethod')

    if (-not $fileContent.StartsWith('function'))
    {
        $fileContent = $fileContent.Insert(0, "function ConvertTo-Expression {`n")
        $fileContent += "}`n"
    }

    $fileContent | Set-Content -Path $filePath -Encoding UTF8

}
