#Import-Module -Name (Join-Path -Path $PSScriptRoot -ChildPath ..\..\output\JeaDsc)

$script:dscModuleName = 'JeaDsc'
$script:dscResourceName = 'JeaRoleCapabilities'
$script:dscPSSessionConfigurationName = 'PS_IntergrationSessionConfiguration'

try
{
    Import-Module -Name DscResource.Test -Force -ErrorAction 'Stop'
}
catch [System.IO.FileNotFoundException]
{
    throw 'DscResource.Test module dependency not found. Please run ".\build.ps1 -Tasks build" first.'
}

$global:testEnvironment = Initialize-TestEnvironment `
    -DSCModuleName $script:dscModuleName `
    -DSCResourceName $script:dscResourceName `
    -ResourceType Mof `
    -TestType Integration

Import-Module -Name (Join-Path -Path $PSScriptRoot -ChildPath '..\TestHelpers\CommonTestHelper.psm1')

InModuleScope JeaDsc {

    Describe 'Integration testing JeaSessionConfiguration AccessModes' -Tag Integration {

        Context "Testing Get Method with AccessMode" {

            BeforeAll {
                $params = @{
                    Path = 'TestDrive:\PS_IntergrationSessionConfiguration.pssc'
                }
                New-PSSessionConfigurationFile @params
            }

            BeforeEach {
                $class = [JeaSessionConfiguration]::New()
                $class.Name = 'PS_IntergrationSessionConfiguration'

                $sessionConfigurationParams = @{
                    Name = 'PS_IntergrationSessionConfiguration'
                    Path = 'TestDrive:\PS_IntergrationSessionConfiguration.pssc'
                }

            }

            AfterEach {
                Unregister-PSSessionConfiguration -Name 'PS_IntergrationSessionConfiguration' -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
            }

            AfterAll {
                Remove-Item -Path 'TestDrive:\PS_IntergrationSessionConfiguration.pssc'
            }

            It 'Should return an AccessMode of "Remote"' {

                $sessionConfigurationParams.AccessMode = 'Remote'
                Register-PSSessionConfiguration @sessionConfigurationParams -WarningAction SilentlyContinue

                $result = $class.Get()
                $result.AccessMode | Should -be 'Remote'

            }

            It 'Should return an AccessMode of "Disabled"' {

                $sessionConfigurationParams.AccessMode = 'Disabled'
                Register-PSSessionConfiguration @sessionConfigurationParams -WarningAction SilentlyContinue

                $result = $class.Get()
                $result.AccessMode | Should -be 'Disabled'

            }

            It 'Should return an AccessMode of "Local"' {

                $sessionConfigurationParams.AccessMode = 'Local'
                Register-PSSessionConfiguration @sessionConfigurationParams -WarningAction SilentlyContinue

                $result = $class.Get()
                $result.AccessMode | Should -be 'Local'

            }

        }

    }

}
