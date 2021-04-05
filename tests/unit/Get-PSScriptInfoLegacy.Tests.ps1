BeforeAll {
    . (Resolve-Path -Path "$PSScriptRoot\..\..\source\private\Get-PSScriptInfoLegacy.ps1")
}

Describe -Name 'Get-PSScriptInfoLegacy.ps1' -Fixture {
    BeforeAll {
    }
    Context 'When valid legacy PSScriptInfo is provided in file' {
        BeforeAll {
            $file = New-Item -Path TestDrive:\file.ps1
            Set-Content -Path $file.fullname -Value "<#PSScriptInfo`n`r.VERSION 1.0.0.0`n`r.AUTHOR John Doe`n`r#>`r`nGet-Test`r`n"            
        }
        It -Name 'Should not throw' {
            { Get-PSScriptInfoLegacy -FilePath $file.fullname } | Should -not -Throw
        }
    }
}
