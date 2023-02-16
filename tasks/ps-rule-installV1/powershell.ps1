# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# ps-rule-install
#

# See details at: https://github.com/microsoft/PSRule-pipelines

[CmdletBinding()]
param (
    # The name of the module to install
    [Parameter(Mandatory = $False)]
    [String]$Module = (Get-VstsInput -Name 'module'),

    # Determine if the PSRule module is updated to the latest version
    [Parameter(Mandatory = $False)]
    [System.Boolean]$Latest = (Get-VstsInput -Name 'latest' -AsBool),

    # Determine if pre-release modules are installed
    [Parameter(Mandatory = $False)]
    [System.Boolean]$PreRelease = (Get-VstsInput -Name 'prerelease' -AsBool)
)

if ($Env:SYSTEM_DEBUG -eq 'true') {
    $VerbosePreference = 'Continue';
}
$ProgressPreference = 'SilentlyContinue';

Write-Host '';
Write-Host "[info] Using PreRelease: $PreRelease";

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

$moduleNames = @($Module)
if ('PSRule' -notin $moduleNames) {
    $moduleNames += 'PSRule';
}

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

Write-Host '[info] Checking PowerShellGet';
Import-Module -Name PowerShellGet -MinimumVersion 2.2.3;

$exitResult = 0;
$moduleParams = @{
    Scope = 'CurrentUser'
    Force = $True
}
if ($PreRelease) {
    $moduleParams['AllowPrerelease'] = $True;
}

# Install each module if not already installed
foreach ($m in $moduleNames) {
    Write-Host "[info] Checking module: $m";
    if ($Null -eq (Get-InstalledModule -Name $m -ErrorAction Ignore)) {
        Write-Host "[info] Installing module: $m";
        $Null = Install-Module -Name $m @moduleParams -AllowClobber;
    }
    elseif ($Latest) {
        Write-Host "[info] Updating module: $m";
        $Null = Update-Module -Name $m @moduleParams;
    }
    else {
        WriteDebug "Module '$m' already installed";
    }
    # Check
    if ($Null -eq (Get-InstalledModule -Name $m)) {
        $exitResult = 1;
        Write-Host "[error] Failed to install module: $m";
    }
    else {
        Write-Host "[info] Using module: $m - v$((Get-InstalledModule -Name $m).Version)";
    }
}
$Host.SetShouldExit($exitResult);
