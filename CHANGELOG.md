# Changelog for JeaDsc

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Adding AccessMode to PSSessionConfiguration.

### Added

- Adding LanguageMode and ExecutionPolicy to JeaSessionConfiguration.
- Adding herited classes that contains helper methods.
- Adding Reason class.
- Adding Reasons property in JeaSessionConfiguration and JeaRoleCapabilities resources.
  It's a requirement of [Guest Configuration](https://docs.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create#get-targetresource-requirements)
- Adding pester tests to check Reasons property.

### Changed

- Moved documentation from README.md to the GitHub repository Wiki.
- Moving the class based resources from nested modules to root module.
- Moving LocalizedData of class based resources in .strings.psd1 files.
Based on [style guidelines](https://dsccommunity.org/styleguidelines/localization/) of DscCommunity.
- Updated the Required Modules and Build.Yaml with Sampler.GitHubTasks.
- Updated pipeline to current pattern and added Invoke-Build tasks.
- Removed the exported DSC resource from the module manifest under the
  source folder. They are automatically added to the module manifest in
  built module during the build process so that contributors don't have
  to add them manually.
- Rearranged the Azure Pipelines jobs in the file `azure-pipelines.yml`
  so it is easier to updated the file from the Sampler's Plaster template
  in the future.
- The HQRM tests was run twice in the pipeline, now they are run just once.
- Updated the README.md with new section and updated the links.

### Removed

- Removing dummy object

## [0.7.2] - 2020-09-29

### Changed

- Moving code from constructor to separate method.

## [0.7.1] - 2020-08-26

- Renamed 'Test-DscParameterState' to 'Test-DscParameterState2' for a conflict with 'DscResource.Common'.
- Removing functions provided by 'DscResource.Common'
- Making property 'RoleDefinitions' non-mandatory
- Replacing 'New-PSRoleCapabilityFile' by writing the file directly
- Making 'ConvertTo-Expression' visible as it is required also from the outside
- Renamed variable '$parameters' into '$desiredState'
- Removing pre-release tag

### Added

- Migrated the resource to Sampler

### Changed

- Fixed a lot of issues.

### Deprecated

- None

### Removed

- None

### Fixed

- None

### Security

- None
