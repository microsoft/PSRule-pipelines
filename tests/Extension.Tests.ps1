# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# Extension unit tests
#

[CmdletBinding()]
param ()

BeforeAll {
    # Setup error handling
    $ErrorActionPreference = 'Stop';
    Set-StrictMode -Version latest;

    if ($Env:SYSTEM_DEBUG -eq 'true') {
        $VerbosePreference = 'Continue';
    }

    # Setup tests paths
    $rootPath = $PWD;
    $extensionOut = Join-Path -Path $rootPath -ChildPath 'out/dist/'

    $here = (Resolve-Path $PSScriptRoot).Path;
    $outputPath = Join-Path -Path $rootPath -ChildPath out/tests/PSRule.Tests/Common;
    Remove-Item -Path $outputPath -Force -Recurse -Confirm:$False -ErrorAction Ignore;
    $Null = New-Item -Path $outputPath -ItemType Directory -Force;

    Import-Module -Name VstsTaskSdk -ArgumentList @{ 'NonInteractive' = 'true' };
}

Describe 'Extension V2' {
    BeforeAll {
        $entryPointPath = (Join-Path -Path $extensionOut -ChildPath 'ps-rule-assert/ps-rule-assertV2/powershell.ps1');
    }

    Context 'With defaults' {
        It 'Runs entrypoint' {
            $taskOptions = @{
                Path = ''
                InputType = 'repository'
                InputPath = ''
                Source = '.ps-rule/'
                Modules = ''
                Baseline = ''
            }
            . $entryPointPath @taskOptions;
        }
    }
}
