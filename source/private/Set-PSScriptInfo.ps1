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
        
    .PARAMETER Name
        Description
    .EXAMPLE
        Set-PSScriptInfo
        Description of example
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

    BEGIN
    {
        try
        {
            $JSON = ("<#PSScriptInfo`n{0}`nPSScriptInfo#>" -f $JSON)
            Write-Verbose 'Added prefix and suffix to JSON block'
        }
        catch
        {
            throw "Failed to add prefix and suffix to JSON block with error: $PSItem"
        }
    }

    PROCESS
    {
        try
        {
            $FileContent = Get-Content -Path $FilePath -ErrorAction Stop
            Write-Verbose -Message ('Read content from filepath')
        }
        catch
        {
            throw ('Failed to read content from filepath with error: {0}' -f $_.exception.message)
        }

        try
        {
            $StringBuilder = [System.Text.StringBuilder]::new(($FileContent) -join "`n")
            Write-Verbose -Message ('Created stringbuilder')
        }
        catch
        {
            throw ('Failed to create stringbuilder with error: {0}' -f $_.exception.message)
        }

        try
        {
            $null = $StringBuilder.Insert(0, ($JSON))
            Write-Verbose -Message ('Inserted PSScriptInfo at beginning of content block')
        }
        catch
        {
            throw ('Failed to insert PSScriptInfo at beginning of content block with error: {0}' -f $_.exception.message)
        }

        try
        {
            $StringBuilder.ToString() | Set-Content -Path $FilePath -Encoding utf8BOM -ErrorAction Stop
            Write-Verbose -Message ('Successfully wrote content block back to file')
        }
        catch
        {
            throw ('Failed to write content block back to file with error: {0}' -f $_.exception.message)
        }

    }

}
#endregion
