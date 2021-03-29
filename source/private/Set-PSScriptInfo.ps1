<#PSScriptInfo
    .VERSION                       1.0.0.0
    .GUID                          48011ba6-1489-4f2b-b620-dc1923486418
    .FILENAME                      Set-PSScriptInfo.ps1
    .AUTHOR                        Hannes Palmquist
    .AUTHOREMAIL                   hannes.palmquist@outlook.com
    .CREATEDDATE                   2019-09-24
    .COMPANYNAME                   N/A
    .COPYRIGHT                     © 2019, Hannes Palmquist, All Rights Reserved
#>

function Set-PSScriptInfo
{
    <#
    .DESCRIPTION
        Adds a PSScriptInfo block to a file
    .PARAMETER FilePath
        FilePath for file to set PSScriptInfo for
    .PARAMETER JSON
        String value containing json formatted PSScriptInfo
    .EXAMPLE
        Set-PSScriptInfo -Filepath C:\Script\Get-Test.ps1 -JSON $JSON
    #>

    [CmdletBinding()] # Enabled advanced function support
    param(
        [ValidateScript( { Test-Path $_.FullName -PathType Leaf })]
        [Parameter(Mandatory)]
        [System.IO.FileInfo]
        $FilePath,
        
        [Parameter(Mandatory)]
        [string]
        $JSON
    )

    try
    {
        $null = $JSON | ConvertFrom-Json -ErrorAction Stop
        Write-Verbose 'Tested JSON input for valid JSON'
    }
    catch
    {
        throw 'Failed to parse input JSON, input is not valid JSON'
    }

    $JSON = ("<#PSScriptInfo`n{0}`nPSScriptInfo#>`n" -f $JSON)
    Write-Verbose 'Added prefix and suffix to JSON block'

    try
    {
        $FileContent = Get-Content -Path $FilePath -ErrorAction Stop
        Write-Verbose -Message ('Read content from filepath')
    }
    catch
    {
        throw ('Failed to read content from filepath with error: {0}' -f $_.exception.message)
    }

    $StringBuilder = [System.Text.StringBuilder]::new(($FileContent) -join "`n")
    Write-Verbose -Message ('Created stringbuilder')

    $null = $StringBuilder.Insert(0, ($JSON))
    Write-Verbose -Message ('Inserted PSScriptInfo at beginning of content block')

    try
    {
        $StringBuilder.ToString() | Set-Content -Path $FilePath -Encoding utf8 -ErrorAction Stop
        Write-Verbose -Message ('Successfully wrote content block back to file')
    }
    catch
    {
        throw ('Failed to write content block back to file with error: {0}' -f $_.exception.message)
    }


}
#endregion
