# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# ps-rule-assert
#

# See details at: https://github.com/Microsoft/PSRule-pipelines

[CmdletBinding()]
param (
    # The root path for analysis
    [Parameter(Mandatory = $False)]
    [String]$Path = (Get-VstsInput -Name 'path'),

    # The type of input
    [Parameter(Mandatory = $False)]
    [ValidateSet('repository', 'inputPath')]
    [String]$InputType = (Get-VstsInput -Name 'inputType'),

     # The path to input files
     [Parameter(Mandatory = $False)]
     [String]$InputPath = (Get-VstsInput -Name 'inputPath'),

    # The path to find rules
    [Parameter(Mandatory = $False)]
    [String]$Source = (Get-VstsInput -Name 'source'),

    # Rule modules to use
    [Parameter(Mandatory = $False)]
    [String]$Modules = (Get-VstsInput -Name 'modules'),

    # The output format
    [Parameter(Mandatory = $False)]
    [ValidateSet('None', 'Yaml', 'Json', 'NUnit3', 'Csv')]
    [String]$OutputFormat = (Get-VstsInput -Name 'outputFormat'),

    # The path to store formatted output
    [Parameter(Mandatory = $False)]
    [String]$OutputPath = (Get-VstsInput -Name 'outputPath') 
)

if ($Env:SYSTEM_DEBUG -eq 'true') {
    $VerbosePreference = 'Continue';
}
if ([String]::IsNullOrEmpty($Path)) {
    $Path = $Env:BUILD_SOURCESDIRECTORY;
}
if ([String]::IsNullOrEmpty($Path)) {
    $Path = $PWD;
}
if ($Null -eq $InputPath) {
    $InputPath = $Path;
}
if ([String]::IsNullOrEmpty($Source)) {
    $Source = Join-Path -Path $Path -ChildPath '.ps-rule/';
}
if (!(Test-Path -Path $Source)) {
    Write-Host "[info] Source '$Source' does not exist.";
    Write-Host '';
}

function WriteDebug {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $True)]
        [String]$Message
    )
    process {
        if ($Env:SYSTEM_DEBUG -eq 'true') {
            Write-Host "[debug] $Message";
        }
    }
}

# Import localized strings
Import-VstsLocStrings -LiteralPath $PSScriptRoot/task.json;

# Setup paths for importing modules
$modulesPath = Join-Path -Path $PSScriptRoot -ChildPath 'ps_modules' -Resolve;
if ((Get-Variable -Name IsMacOS -ErrorAction Ignore) -or (Get-Variable -Name IsLinux -ErrorAction Ignore)) {
    $moduleSearchPaths = $Env:PSModulePath.Split(':', [System.StringSplitOptions]::RemoveEmptyEntries);
    if ($modulesPath -notin $moduleSearchPaths) {
        $Env:PSModulePath += [String]::Concat($Env:PSModulePath, ':', $modulesPath);
    }
}
else {
    $moduleSearchPaths = $Env:PSModulePath.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries);
    if ($modulesPath -notin $moduleSearchPaths) {
        $Env:PSModulePath += [String]::Concat($Env:PSModulePath, ';', $modulesPath);
    }
}

$moduleNames = @()
if (![String]::IsNullOrEmpty($Modules)) {
    $moduleNames = $Modules.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries);
}
$moduleParams = @{
    Scope = 'CurrentUser'
    Force = $True
}

# Install each module if not already installed
foreach ($m in $moduleNames) {
    Write-Host "> Checking module: $m";
    if ($Null -eq (Get-InstalledModule -Name $m -ErrorAction Ignore)) {
        Write-Host '  - Installing module';
        $Null = Install-Module -Name $m @moduleParams -AllowClobber;
    }
    else {
        Write-Host '  - Already installed';
    }
    # Check
    if ($Null -eq (Get-InstalledModule -Name $m)) {
        Write-Host '  - Failed to install';
    }
    else {
        Write-Host "  - Using version: $((Get-InstalledModule -Name $m).Version)";
    }
}

Write-Host '';
Write-Host "[info] Using PWD: $PWD";
Write-Host "[info] Using Path: $Path";
Write-Host "[info] Using Source: $Source";
Write-Host "[info] Using InputType: $InputType";
Write-Host "[info] Using InputPath: $InputPath";
Write-Host "[info] Using OutputFormat: $OutputFormat";
Write-Host "[info] Using OutputPath: $OutputPath";

try {
    Push-Location -Path $Path;
    $invokeParams = @{
        Path = $Source
        Option = (New-PSRuleOption -TargetName 'FullName')
        Style = 'AzurePipelines'
        ErrorAction = 'Stop'
    }
    WriteDebug "Preparing command-line:";
    WriteDebug ([String]::Concat('-Path ''', $Source, ''''));
    if (![String]::IsNullOrEmpty($Modules)) {
        $moduleNames = $Modules.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries);
        $invokeParams['Module'] = $moduleNames;
        WriteDebug ([String]::Concat('-Module ', [String]::Join(', ', $moduleNames)));
    }
    if (![String]::IsNullOrEmpty($OutputFormat) -and ![String]::IsNullOrEmpty($OutputPath) -and $OutputFormat -ne 'None') {
        $invokeParams['OutputFormat'] = $OutputFormat;
        $invokeParams['OutputPath'] = $OutputPath;
        WriteDebug ([String]::Concat('-OutputFormat ', $OutputFormat, ' -OutputPath ''', $OutputPath, ''''));
    }

    # Repository
    if ($InputType -eq 'repository') {
        WriteDebug 'Running ''Assert-PSRule'' with repository as input.';
        Write-Host '';
        Write-Host '---';
        Assert-PSRule @invokeParams -InputPath $InputPath -Format File;
    }
    # Repository
    elseif ($InputType -eq 'inputPath') {
        WriteDebug 'Running ''Assert-PSRule'' with input from path.';
        Write-Host '';
        Write-Host '---';
        Assert-PSRule @invokeParams -InputPath $InputPath;
    }
}
catch {
    Write-Host "`#`#vso[task.logissue type=error]$(Get-VstsLocString -Key 'AssertFailed')";
    Write-Host "`#`#vso[task.complete result=Failed;]FAILED";
    $Host.SetShouldExit(1);
}
finally {
    Pop-Location;
}
Write-Host '---';
