﻿
@{
  RootModule = 'pstools.psscriptinfo.psm1'
  ModuleVersion = '1.0.1'
  CompatiblePSEditions = @('Desktop','Core')
  GUID = 'f49be34c-e1a9-4e1e-9a98-ed2b72b78efa'
  Author = 'Hannes Palmquist'
  CompanyName = ''
  Copyright = '(c) 2021 Hannes Palmquist. All rights reserved.'
  Description = 'Tools for generating and updating psscriptinfo on scripts'
  RequiredModules = @()
  FunctionsToExport = @('Add-PSScriptInfo','Get-PSScriptInfo','Remove-PSScriptInfo','Update-PSScriptInfo')
  FileList = @('.\data\appicon.ico','.\data\banner.ps1','.\docs\pstools.psscriptinfo.md','.\include\module.utility.functions.ps1','.\private\Set-PSScriptInfo.ps1','.\public\Add-PSScriptInfo.ps1','.\public\Get-PSScriptInfo.ps1','.\public\Remove-PSScriptInfo.ps1','.\public\Update-PSScriptInfo.ps1','.\settings\config.json','.\LICENSE.txt','.\pstools.psscriptinfo.psd1','.\pstools.psscriptinfo.psm1')
  PrivateData = @{
    ModuleName = 'pstools.psscriptinfo.psm1'
    DateCreated = '2021-03-27'
    LastBuildDate = '2021-03-28'
    PSData = @{
      Tags = @('PSEdition_Desktop','PSEdition_Core','Windows','Linux','MacOS')
      ProjectUri = 'https://getps.dev/modules/pstools.psscriptinfo/quickstart'
      LicenseUri = 'https://github.com/hanpq/pstools.psscriptinfo/blob/main/LICENSE'
      ReleaseNotes = 'https://getps.dev/modules/pstools.psscriptinfo/changelog'
      IsPrerelease = 'False'
      IconUri = ''
      PreRelease = ''
      RequireLicenseAcceptance = $True
      ExternalModuleDependencies = @()
    }
  }
  CmdletsToExport = @()
  VariablesToExport = @()
  AliasesToExport = @()
  DscResourcesToExport = @()
  ModuleList = @()
  RequiredAssemblies = @()
  ScriptsToProcess = @()
  TypesToProcess = @()
  FormatsToProcess = @()
  NestedModules = @()
  HelpInfoURI = ''
  DefaultCommandPrefix = ''
  PowerShellVersion = '5.1'
  PowerShellHostName = ''
  PowerShellHostVersion = ''
  DotNetFrameworkVersion = ''
  CLRVersion = ''
  ProcessorArchitecture = ''
}




