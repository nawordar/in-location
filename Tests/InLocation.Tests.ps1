$Verbose = @{ }
if ($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master") {
    $Verbose.add("Verbose", $True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module ..\InLocation.psm1 -Force

Describe "InLocation PS$PSVersion" {

    Context 'Strict mode' { 

        Set-StrictMode -Version latest

        It "should change to the inner directory and return the value of the callback" {
            $wd = "SampleWorkingDirectory"
            $result = ""
            function CallbackFunction {
                (Get-Item -Path ".\").FullName
            }

            $result = InLocation($wd) {
                CallbackFunction
            }

            $expected = Join-Path $PSScriptRoot $wd

            $result | Should be $expected
        }

    } 
}