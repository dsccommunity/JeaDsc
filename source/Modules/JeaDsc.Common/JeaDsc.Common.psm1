using namespace System.Management.Automation.Language

function Convert-ObjectToHashtable
{
    [OutputType([hashtable])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object]$Object
    )

    process
    {
        $hashtable = @{ }

        foreach ($property in $Object.PSObject.Properties.Where({ $_.Value }))
        {
            $hashtable.Add($property.Name, $property.Value)
        }

        $hashtable
    }
}

function Convert-StringToObject
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowNull()]
        [string[]]$InputString
    )

    process
    {
        foreach ($string in $InputString)
        {
            $parseErrors = @()
            $fakeCommand = "Totally-NotACmdlet -Fakeparameter $string"
            $ast = [Parser]::ParseInput($fakeCommand, [ref]$null, [ref]$parseErrors)

            $pattern = ',(?<ArrayElements>.+)'
            if (($parseErrors | Where-Object ErrorId -eq MissingArgument) -and $string -match $pattern)
            {
                $fakeCommand = "Totally-NotACmdlet -Fakeparameter $($Matches.ArrayElements)"
                $ast = [Parser]::ParseInput($fakeCommand, [ref]$null, [ref]$parseErrors)
            }

            if (-not $parseErrors)
            {
                # Use Ast.Find() to locate the CommandAst parsed from our fake command
                $cmdAst = $ast.Find( {
                        param (
                            [Parameter(Mandatory = $true)]
                            [System.Management.Automation.Language.Ast]$ChildAst
                        )
                        $ChildAst -is [CommandAst]
                    }
                    , $false
                )
                # Grab the user-supplied arguments (index 0 is the command name, 1 is our fake parameter)
                $argumentAsts = $cmdAst.CommandElements.Where( { $_ -isnot [CommandparameterAst] -and $_.Value -ne 'Totally-NotACmdlet' })
                foreach ($argumentAst in $argumentAsts)
                {
                    if ($argumentAst -is [ArrayLiteralAst])
                    {
                        # Argument was a list
                        foreach ($element in $argumentAst.Elements)
                        {
                            if ($element.StaticType.Name -eq 'String')
                            {
                                $element.value
                            }
                            if ($element.StaticType.Name -eq 'Hashtable')
                            {
                                [hashtable]$element.SafeGetValue()
                            }
                        }
                    }
                    else
                    {
                        if ($argumentAst -is [HashtableAst])
                        {
                            $ht = [Hashtable]$argumentAst.SafeGetValue()
                            for ($i = 0; $i -lt $ht.Keys.Count; $i++)
                            {
                                $value = $ht[([array]$ht.Keys)[$i]]
                                if ($value -is [scriptblock])
                                {
                                    $scriptBlockText = $value.Ast.Extent.Text

                                    if ($scriptBlockText[$value.Ast.Extent.StartOffset] -eq '{' -and $scriptBlockText[$value.Ast.Extent.EndOffset - 1] -eq '}')
                                    {
                                        $scriptBlockText = $scriptBlockText.Substring(0, $scriptBlockText.Length - 1)
                                        $scriptBlockText = $scriptBlockText.Substring(1, $scriptBlockText.Length - 1)
                                    }

                                    $ht[([array]$ht.Keys)[$i]] = [scriptblock]::Create($scriptBlockText)
                                }
                            }
                            $ht
                        }
                        elseif ($argumentAst -is [StringConstantExpressionAst])
                        {
                            $argumentAst.Value
                        }
                        else
                        {
                            Write-Error -Message $script:localizedData.InputNotHashtableOrCollection
                        }
                    }
                }
            }
        }
    }
}

function Sync-Parameter
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript( {
                $_ -is [System.Management.Automation.FunctionInfo] -or
                $_ -is [System.Management.Automation.CmdletInfo] -or
                $_ -is [System.Management.Automation.ExternalScriptInfo] -or
                $_ -is [System.Management.Automation.AliasInfo]
            })]
        [object]$Command,

        [Parameter(Mandatory = $true)]
        [hashtable]$Parameters
    )

    if ($Command -is [System.Management.Automation.AliasInfo] -and $Command.Definition -like 'PesterMock*')
    {
        $Command = Get-Command -Name $Command.Name
    }

    $commonParameters = [System.Management.Automation.Internal.CommonParameters].GetProperties().Name
    $commandParameterKeys = $Command.Parameters.Keys.GetEnumerator() | foreach-Object { $_ }
    $parameterKeys = $Parameters.Keys.GetEnumerator() | foreach-Object { $_ }

    $keysToRemove = Compare-Object -ReferenceObject $commandParameterKeys -DifferenceObject $parameterKeys |
        Select-Object -ExpandProperty InputObject

    $keysToRemove = $keysToRemove + $commonParameters | Select-Object -Unique #remove the common parameters

    foreach ($key in $keysToRemove)
    {
        $Parameters.Remove($key)
    }

    $Parameters
}

$modulePath = Join-Path -Path (Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent) -ChildPath Modules
Import-Module -Name (Join-Path -Path $modulePath -ChildPath DscResource.Common)

$script:localizedData = Get-LocalizedData -DefaultUICulture en-US
