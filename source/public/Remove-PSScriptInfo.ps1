<#PSScriptInfo
    .VERSION                       1.0.0.0
    .GUID                          1d1a8e42-48bf-4c9f-9d62-e01484b5eb1a
    .FILENAME                      Remove-PSScriptInfo.ps1
    .AUTHOR                        Hannes Palmquist
    .AUTHOREMAIL                   hannes.palmquist@outlook.com
    .CREATEDDATE                   2021-03-28
    .COMPANYNAME                   N/A
    .COPYRIGHT                     © 2021, Hannes Palmquist, All Rights Reserved
#>

function Remove-PSScriptInfo
{
    <#
    .DESCRIPTION
        
    .PARAMETER Name
        Description
    .EXAMPLE
        Remove-PSScriptInfo
        Description of example
    #>

    [CmdletBinding()] # Enabled advanced function support
    param(
        [ValidateScript( { Test-Path -Path $_.FullName -PathType Leaf })]
        [Parameter(Mandatory)]
        [system.io.fileinfo]
        $FilePath,

        [hashtable]
        $Properties
    )

    PROCESS
    {

        # Read ast tokens from file
        try
        {
            New-Variable astTokens -Force -ErrorAction Stop
            New-Variable astErr -Force -ErrorAction Stop
            $null = [System.Management.Automation.Language.Parser]::ParseFile($FilePath, [ref]$astTokens, [ref]$astErr)
            Write-Verbose -Message 'Read file content'
        }
        catch
        {
            throw "Failed to read file content with error: $PSItem"
        }

        # Find PSScriptInfo comment token
        try
        {
            $PSScriptInfo = $astTokens.where{ $_.kind -eq 'comment' -and $_.text.Replace("`r", '').Split("`n")[0] -like '<#PSScriptInfo*' }
            Write-Verbose -Message 'Parsed powershell script file and extracted raw PSScriptInfoText'
        }
        catch
        {
            throw "Failed to parse powershell script file with error: $PSItem"
        }

        if (-not $PSScriptInfoText)
        {
            throw 'No PSScriptInfo found in file'
        }

        $StartLine = $PSScriptInfo.extent.StartLineNumber
        $EndLine = $PSScriptInfo.extent.EndLineNumber

        # Read file
        try
        {
            $FileContent = Get-Content -Path $FilePath -ErrorAction Stop
            Write-Verbose -Message 'Collected file content'
        }
        catch
        {
            throw "Failed to read file content with error: $PSItem"
        }
        
        # Exclude PSScriptInfo
        try
        {
            $NewContent = ($FileContent | Select-Object -First ($StartLine - 1) -ErrorAction stop) + ($FileContent | Select-Object -Skip ($EndLine + 1) -ErrorAction Stop)
            Write-Verbose -Message 'Concatinated content around removed PSScriptInfo'
        }
        catch
        {
            throw "Failed to concatinate strings with error: $PSItem"
        }

        # Write content back to file
        try
        {
            $NewContent | Set-Content -Path $FilePath -ErrorAction Stop
            Write-Verbose -Message 'Wrote content to back to file'
        }
        catch
        {
            throw "Failed to write content back to file with error: $PSItem"
        }

    }
}
#endregion
