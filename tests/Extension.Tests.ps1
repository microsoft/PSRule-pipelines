#
# Unit tests extension
#

[CmdletBinding()]
param (

)

# Setup error handling
$ErrorActionPreference = 'Stop';
Set-StrictMode -Version latest;

if ($Env:SYSTEM_DEBUG -eq 'true') {
    $VerbosePreference = 'Continue';
}

# Setup tests paths
$rootPath = $PWD;

$here = (Resolve-Path $PSScriptRoot).Path;
$outputPath = Join-Path -Path $rootPath -ChildPath out/tests/PSRule.Tests/Common;
Remove-Item -Path $outputPath -Force -Recurse -Confirm:$False -ErrorAction Ignore;
$Null = New-Item -Path $outputPath -ItemType Directory -Force;

# Describe 'Extension' {
#     $entryPointPath = (Join-Path -Path $rootPath -ChildPath 'tasks/ps-rule-assert/powershell.ps1');

#     Context 'With defaults' {
#         It 'Runs entrypoint' {
#             . $entryPointPath -Path $PWD;
#         }
#     }
# }
