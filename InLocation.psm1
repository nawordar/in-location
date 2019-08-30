function InLocation {
    <#
    .SYNOPSIS
        Change working directory to $Location, run $Callback and return to the previous directory

    .PARAMETER Location
        Location to which the working directory will be changed
    .PARAMETER Callback
        Callback which will be call in the given $Location
    #>
    [cmdletbinding()]
    Param(
        [String]$Location,
        [ScriptBlock]$Callback
    )
    $originalLocation = Get-Location

    Set-Location $Location
    $return = &$Callback
    Set-Location $originalLocation

    $return
}

Export-ModuleMember -Function InLocation