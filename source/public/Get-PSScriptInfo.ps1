<#PSScriptInfo
    .VERSION                       1.0.0.0
    .GUID                          dd14abf0-8b1b-425f-9498-8dfaf657ae9f
    .FILENAME                      Get-PSScriptInfo.ps1
    .AUTHOR                        Hannes Palmquist
    .AUTHOREMAIL                   hannes.palmquist@outlook.com
    .CREATEDDATE                   2019-09-23
    .COMPANYNAME                   N/A
    .COPYRIGHT                     (c) 2019, Hannes Palmquist, All Rights Reserved
#>

function Get-PSScriptInfo
{
    <#
        .DESCRIPTION
            Collect and parse psscriptinfo from file
        .PARAMETER FilePath
            Defines the path to the file from which to get psscriptinfo from.
        .EXAMPLE
            Get-PSScriptInfo -FilePath C:\temp\file.ps1
    #>

    [CmdletBinding()] # Enabled advanced function support
    param(
        [ValidateScript( { Test-Path -Path $_.FullName -PathType Leaf })]
        [Parameter(Mandatory)]
        [system.io.fileinfo]
        $FilePath
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
            $PSScriptInfoText = $astTokens.where{ $_.kind -eq 'comment' -and $_.text.Replace("`r", '').Split("`n")[0] -like '<#PSScriptInfo*' } | Select-Object -expand text
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

        # Extract PSScriptInfo from JSON
        try
        {
            $PSScriptInfo = $PSScriptInfoText.Split("`n") | Select-Object -Skip 1 -ErrorAction Stop | Select-Object -SkipLast 1 -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
            Write-Verbose -Message 'Parsed PSScriptInfo to JSON'
        }
        catch
        {
            throw "Failed to parse PSScriptInfo to JSON with error: $PSItem"
        }

        return $PSScriptInfo
    }
}
#endregion

