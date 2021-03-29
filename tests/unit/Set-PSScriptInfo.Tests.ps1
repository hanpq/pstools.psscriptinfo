BeforeAll {
    . (Resolve-Path -Path "$PSScriptRoot\..\..\source\private\Set-PSScriptInfo.ps1")
}

Describe -Name 'Set-PSScriptInfo.ps1' -Fixture {
    BeforeAll {
    }
    Context -Name 'When passing valid JSON and file exists' {
        BeforeEach {
            $File = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $File.FullName -Value 'Get-Test'
            
        }
        AfterEach {
            Remove-Item $File.FullName
        }
        It -Name 'Should not throw' {
            { Set-PSScriptInfo -FilePath $File.FullName -JSON "{`n`r`"Version`":`"1.0.0.0`"`n`r}" } | Should -Not -Throw
        }
        It -Name 'Should contain correct content' {
            Set-PSScriptInfo -FilePath $File.FullName -JSON "{`n`r`"Version`":`"1.0.0.0`"`n`r}"
            $Content = Get-Content $File.FullName -Raw | Should -Be "<#PSScriptInfo`n{`n`r`"Version`":`"1.0.0.0`"`n`r}`nPSScriptInfo#>`nGet-Test`r`n"
        }
    }
    Context -Name 'When passing invalid json' {
        BeforeEach {
            $File = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $File.FullName -Value 'Get-Test'
            
        }
        AfterEach {
            Remove-Item $File.FullName
        }
        It -Name 'Should throw' {
            { Set-PSScriptInfo -FilePath $File.FullName -JSON "`n`r`"Version`":`"1.0.0.0`"`n`r}" } | Should -Throw
        }
    }
    Context -Name 'When file does not exist' {
        It -Name 'Should throw' {
            { Set-PSScriptInfo -FilePath $File.FullName -JSON "{`n`r`"Version`":`"1.0.0.0`"`n`r}" } | Should -Throw
        }
    }
    Context -Name 'When writing to file fails' {
        BeforeEach {
            $File = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $File.FullName -Value 'Get-Test'
            Mock Set-Content -MockWith { throw }
        }
        AfterEach {
            Remove-Item $File.FullName
        }
        It -Name 'Should throw' {
            { Set-PSScriptInfo -FilePath $File.FullName -JSON "{`n`r`"Version`":`"1.0.0.0`"`n`r}" } | Should -Throw
        }
    }
}
