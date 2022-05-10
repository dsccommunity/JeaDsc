# Welcome to the JeaDsc wiki

<sup>*JeaDsc v#.#.#*</sup>

The DSC resources can help you quickly and consistently deploy JEA endpoints
across your enterprise.

Just Enough Administration (JEA) is a PowerShell security technology that
provides a role based access control platform for anything that can be managed
with PowerShell. It enables authorized users to run specific commands in
an elevated context on a remote machine, complete with full PowerShell
transcription and logging. JEA is included in PowerShell version 5 and higher
on Windows 10 and Windows Server 2016, and older OSes with the Windows Management
Framework updates.

This repository contains sample role capabilities created by the Microsoft IT
team and the official DSC resource that can be used to deploy JEA across your enterprise.
General information and documentation for JEA can be found at [Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/overview).

## Sample Role Capabilities

Microsoft IT have been working with JEA since its inception and have shared
some of their role capabilities for general server and IIS maintenance/support.
[Check them out](https://github.com/dsccommunity/JeaDsc/tree/master/source/Examples)
to learn more about how to create role capability files or download them to
use in your own environment.

## Deprecated resources

The documentation, examples, unit test, and integration tests have been removed
for these deprecated resources. These resources will be removed
in a future release.

*None*

## Getting started

To get started either:

- Install from the PowerShell Gallery using PowerShellGet by running the
  following command:

```powershell
Install-Module -Name JeaDsc -Repository PSGallery
```

- Download JeaDsc from the [PowerShell Gallery](https://www.powershellgallery.com/packages/JeaDsc)
  and then unzip it to one of your PowerShell modules folders (such as
  `$env:ProgramFiles\WindowsPowerShell\Modules`).

To confirm installation, run the below command and ensure you see the JeaDsc
DSC resources available:

```powershell
Get-DscResource -Module JeaDsc
```

## Change log

A full list of changes in each version can be found in the [change log](https://github.com/dsccommunity/JeaDsc/blob/main/CHANGELOG.md).

Please leave comments, feature requests, and bug reports for this module in
the [issues section](https://github.com/dsccommunity/JeaDsc/issues)
for this repository.
