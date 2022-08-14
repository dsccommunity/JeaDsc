Configuration DisableDefaultPowerShell
{
    Import-DscResource -Module JeaDsc

    JeaSessionConfiguration DnsManagementEndpoint
    {
        Name                = 'microsoft.powershell'
        AccessMode          = 'Disabled'
    }
}

Remove-Item -Path C:\DscTest\* -ErrorAction SilentlyContinue
DisableDefaultPowerShell -OutputPath C:\DscTest -Verbose

Start-DscConfiguration -Path C:\DscTest -Wait -Verbose -Force
