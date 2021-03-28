<#PSScriptInfo
    .VERSION                       1.0.0.0
    .GUID                          d7aa9d44-79bc-49d3-867f-97a760ca8c8f
    .FILENAME                      Update-PSScriptInfo.ps1
    .AUTHOR                        Hannes Palmquist
    .AUTHOREMAIL                   hannes.palmquist@outlook.com
    .CREATEDDATE                   2019-09-24
    .COMPANYNAME                   N/A
    .COPYRIGHT                     © 2019, Hannes Palmquist, All Rights Reserved
#>

function Update-PSScriptInfo
{
    <#
    .DESCRIPTION
        
    .PARAMETER Name
        Description
    .EXAMPLE
        Update-PSScriptInfo
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

        try
        {
            $PSScriptInfo = Get-PSScriptInfo -FilePath $FilePath -ErrorAction Stop
            Write-Verbose 'Found existing PSScriptInfo'
        }
        catch
        {
            throw "Could not collect existing PSScriptInfo to update. Error: $PSItem"
        }

        foreach ($key in $Properties.keys)
        {
            # Missing attribute, add 
            if ($PSScriptInfo.PSObject.Properties.Name -notcontains $key)
            {
                $PSScriptInfo | Add-Member -Name $Key -MemberType NoteProperty -Value $Properties[$key]
            }
            # Existing attribute
            else
            {
                # Remove if property is set to null
                if ($null -eq $Properties[$key])
                {
                    $PSScriptInfo = $PSScriptInfo | Select-Object -Property * -ExcludeProperty $key
                }
                # Not null, update value
                else 
                {
                    $PSScriptInfo.$Key = $Properties[$key]
                }
            }
        }

        try
        {
            $JSON = $PSScriptInfo | ConvertTo-Json -ErrorAction Stop
            Write-Verbose -Message 'Converted updated PSScriptInfo to JSON'
        }
        catch 
        {
            throw 'Failed to convert new PSScriptInfo to JSON'
        }

        try
        {
            Remove-PSScriptInfo -FilePath $FilePath -ErrorAction Stop
            Write-Verbose -Message 'Removed old PSScriptInfo from file'
        }
        catch 
        {
            throw "Failed to remove old PSScriptInfo from file with error: $PSItem"
        }
        
        try
        {
            Set-PSScriptInfo -FilePath $FilePath -JSON $JSON -ErrorAction Stop
            Write-Verbose -Message 'Added updated PSScriptInfo to file'
        }
        catch
        {
            throw "Failed to add updated PSScriptInfo to file with error: $PSItem"
        }
    }
}
#endregion
