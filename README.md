# JeaDsc

This module contains DSC resources for the management and configuration of
Just Enough Administration (JEA), a PowerShell security technology that
provides a role based access control platform for anything that can be
managed with PowerShell..

[![Build Status](https://dev.azure.com/dsccommunity/JeaDsc/_apis/build/status/dsccommunity.JeaDsc?branchName=master)](https://dev.azure.com/dsccommunity/JeaDsc/_build/latest?definitionId=38&branchName=master)
![Azure DevOps coverage (branch)](https://img.shields.io/azure-devops/coverage/dsccommunity/JeaDsc/38/master)
[![codecov](https://codecov.io/gh/dsccommunity/JeaDsc/branch/master/graph/badge.svg)](https://codecov.io/gh/dsccommunity/JeaDsc)
[![Azure DevOps tests](https://img.shields.io/azure-devops/tests/dsccommunity/JeaDsc/38/master)](https://dsccommunity.visualstudio.com/JeaDsc/_test/analytics?definitionId=38&contextType=build)
[![PowerShell Gallery (with prereleases)](https://img.shields.io/powershellgallery/vpre/JeaDsc?label=JeaDsc%20Preview)](https://www.powershellgallery.com/packages/JeaDsc/)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/JeaDsc?label=JeaDsc)](https://www.powershellgallery.com/packages/JeaDsc/)

## Code of Conduct

This project has adopted this [Code of Conduct](CODE_OF_CONDUCT.md).

## Releases

For each merge to the branch `master` a preview release will be
deployed to [PowerShell Gallery](https://www.powershellgallery.com/).
Periodically a release version tag will be pushed which will deploy a
full release to [PowerShell Gallery](https://www.powershellgallery.com/).

## Contributing

Please check out common DSC Community [contributing guidelines](https://dsccommunity.org/guidelines/contributing).

## Change log

A full list of changes in each version can be found in the [change log](CHANGELOG.md).

## Documentation

The documentation can be found in the [JeaDsc Wiki](https://github.com/dsccommunity/JeaDsc/wiki).
The DSC resources files is used to automatically update the documentation 
on each PR merge.

To find out more about JEA, see documentation at [Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/overview).

### Examples

You can review the [Examples](/source/Examples) directory in the JeaDsc module
for some general use scenarios for all of the resources that are in the module.

The resource examples are also available in the [JeaDsc Wiki](https://github.com/dsccommunity/JeaDsc/wiki).

## Just Enough Administration Samples and Resources

Just Enough Administration (JEA) is a PowerShell security technology that provides a role based access control platform for anything that can be managed with PowerShell.
It enables authorized users to run specific commands in an elevated context on a remote machine, complete with full PowerShell transcription and logging.
JEA is included in PowerShell version 5 and higher on Windows 10 and Windows Server 2016, and older OSes with the Windows Management Framework updates.

This repository contains sample role capabilities created by the Microsoft IT team and the official DSC resource that can be used to deploy JEA across your enterprise.
General information and documentation for JEA has migrated to [MSDN](http://aka.ms/JEAdocs).

## DSC Resource

The [JEA DSC resource](https://github.com/dsccommunity/JeaDsc/tree/master/DSCClassResources) can help you quickly and consistently deploy JEA endpoints across your enterprise.
The *JeaSessionConfiguration* DSC resource configures the PowerShell session configurations, which define the mapping of users to roles and general session security settings. *Note:* Scriptblock logging is not enabled by this resource and should be done using the [registry resource](https://docs.microsoft.com/en-us/powershell/dsc/registryresource).
The *JeaRoleCapabilities* DSC resource creates the Role Capabilities file in the specified location using the specified settings.
Check out the [Demo Config](https://github.com/dsccommunity/JeaDsc) for an example of how to deploy a JEA endpoint using these DSC resources.

## Sample Role Capabilities

Microsoft IT have been working with JEA since its inception and have shared some of their role capabilities for general server and IIS maintenance/support.
[Check them out](./Samples) to learn more about how to create role capability files or download them to use in your own environment!
