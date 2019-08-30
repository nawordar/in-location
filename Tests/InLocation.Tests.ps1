$Verbose = @{ }
if ($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master") {
    $Verbose.add("Verbose", $True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\InLocation.psm1 -Force

Describe "InLocation PS$PSVersion" {

    Context 'Strict mode' { 

        Set-StrictMode -Version latest

        It "should change to the inner directory and return the value of the callback" {

            $sampleDirectory = "SampleDirectory"
            $sampleDirectoryLocation = Join-Path $PSScriptRoot $sampleDirectory

            # Create test directory if it does not exist
            if (-Not (Test-Path $sampleDirectoryLocation)) {
                New-Item -Path $sampleDirectoryLocation -ItemType Directory
            }
            
            function CallbackFunction {
                (Get-Item -Path ".\").FullName
            }

            $result = InLocation($sampleDirectoryLocation) {
                CallbackFunction
            }

            $result | Should be $sampleDirectoryLocation
        }

    } 
}
