﻿BeforeAll {
    . (Resolve-Path -Path "$PSScriptRoot\..\..\source\public\Remove-PSScriptInfo.ps1")
}

Describe -Name 'Remove-PSScriptInfo.ps1' -Fixture {
    BeforeAll {
    }
    Context -Name 'When file do not exist' {
        It 'Should throw' {
            { Remove-PSScriptInfo -FilePath 'C:\Script\file.ps1' } | Should -Throw
        }
    }
    Context -Name 'When file exist but is not valid powershell' {
        BeforeAll {
            $file = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $file.fullname -Value 'function {}}'
        }
        It 'Should throw' {
            { Remove-PSScriptInfo -FilePath $file.fullname } | Should -Throw
        }
    }
    Context -Name 'When getting content fails' {
        BeforeAll {
            $file = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $file.fullname -Value "<#PSScriptInfo`n{`n`r`"Version`":`"1.0.0.0`"`n`r}`nPSScriptInfo#>`nGet-Test`r`n"
            Mock Get-Content -MockWith { throw }
        }        
        It 'Should throw' {
            { Remove-PSScriptInfo -FilePath $file.fullname } | Should -Throw
        }
    }
    Context -Name 'When setting content fails' {
        BeforeAll {
            $file = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $file.fullname -Value "<#PSScriptInfo`n{`n`r`"Version`":`"1.0.0.0`"`n`r}`nPSScriptInfo#>`nGet-Test`r`n"
            Mock Set-Content -MockWith { throw }
        }        
        It 'Should throw' {
            { Remove-PSScriptInfo -FilePath $file.fullname } | Should -Throw
        }
    }
    Context -Name 'When file is valid and contains valid psscriptinfo' {
        BeforeAll {
            $file = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $file.fullname -Value "<#PSScriptInfo`n{`n`r`"Version`":`"1.0.0.0`"`n`r}`nPSScriptInfo#>`nGet-Test`r`n"
        }        
        It 'Should not throw' {
            { Remove-PSScriptInfo -FilePath $file.fullname } | Should -Not -Throw
        }
    }
}
