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

    # A baseline to use
    [Parameter(Mandatory = $False)]
    [String]$Baseline = (Get-VstsInput -Name 'baseline'),

    # A comma separated list of conventions to use.
    [Parameter(Mandatory = $False)]
    [String]$Conventions = (Get-VstsInput -Name 'conventions'),

    # The path to an options file.
    [Parameter(Mandatory = $False)]
    [String]$Option = (Get-VstsInput -Name 'option'),

    # Filters output to include results with the specified outcome.
    [Parameter(Mandatory = $False)]
    [String]$Outcome = (Get-VstsInput -Name 'outcome'),

    # The output format
    [Parameter(Mandatory = $False)]
    [ValidateSet('None', 'Yaml', 'Json', 'Markdown', 'NUnit3', 'Csv', 'Sarif')]
    [String]$OutputFormat = (Get-VstsInput -Name 'outputFormat'),

    # The path to store formatted output
    [Parameter(Mandatory = $False)]
    [String]$OutputPath = (Get-VstsInput -Name 'outputPath'),

    # Determine if a pre-release module version is installed.
    [Parameter(Mandatory = $False)]
    [System.Boolean]$PreRelease = (Get-VstsInput -Name 'prerelease' -AsBool),

    # The name of the PowerShell repository where PSRule modules are installed from.
    [String]$Repository = (Get-VstsInput -Name 'repository'),

    # The specific version of PSRule to use.
    [Parameter(Mandatory = $False)]
    [String]$Version = (Get-VstsInput -Name 'version')
)

$workspacePath = $Env:BUILD_SOURCESDIRECTORY;
$ProgressPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue;
if ($Env:SYSTEM_DEBUG -eq 'true') {
    $VerbosePreference = [System.Management.Automation.ActionPreference]::Continue;
}

# Check inputType
if ([String]::IsNullOrEmpty($InputType) -or $InputType -notin 'repository', 'inputPath') {
    $InputType = 'repository';
}

# Set workspace
if ([String]::IsNullOrEmpty($workspacePath)) {
    $workspacePath = $PWD;
}

# Set Path
if ([String]::IsNullOrEmpty($Path)) {
    $Path = $workspacePath;
}

# Set InputPath
if ([String]::IsNullOrEmpty($InputPath)) {
    $InputPath = $Path;
}

# Set Source
if ([String]::IsNullOrEmpty($Source)) {
    $Source = Join-Path -Path $Path -ChildPath '.ps-rule/';
}

# Set conventions
if (![String]::IsNullOrEmpty($Conventions)) {
    $Conventions = @($Conventions.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries) | ForEach-Object {
        $_.Trim();
    });
}
else {
    $Conventions = @();
}

# Set repository
if ([String]::IsNullOrEmpty($Repository)) {
    $Repository = 'PSGallery'
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

function HostExit {
    [CmdletBinding()]
    param ()
    process {
        Write-Host "`#`#vso[task.complete result=Failed;]FAILED";
        $Host.SetShouldExit(1);
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

#
# Check and install modules
#

Write-Host "`#`#[group]Checking PSRule";

$dependencyFile = Join-Path -Path $PSScriptRoot -ChildPath 'modules.json';
$latestVersion = (Get-Content -Path $dependencyFile -Raw | ConvertFrom-Json).dependencies.PSRule.version;
$checkParams = @{
    RequiredVersion = $latestVersion
}
if (![String]::IsNullOrEmpty($Version)) {
    $checkParams['RequiredVersion'] = $Version;
    if ($PreRelease -eq $True) {
        $checkParams['AllowPrerelease'] = $True;
    }
}

# Look for existing versions of PSRule
Write-Host "[info] Using repository: $Repository";
$installed = @(Get-InstalledModule -Name PSRule @checkParams -ErrorAction Ignore)
if ($installed.Length -eq 0) {
    Write-Host "[info] Installing PSRule: $($checkParams.RequiredVersion)";
    $Null = Install-Module -Repository $Repository -Name PSRule @checkParams -Scope CurrentUser -Force -SkipPublisherCheck;
}
foreach ($m in $installed) {
    Write-Host "[info] Using existing module $($m.Name): $($m.Version)";
}

Write-Host "`#`#[endgroup]";

#
# Look for existing modules
#

Write-Host "`#`#[group]Checking modules";

$moduleNames = @()
if (![String]::IsNullOrEmpty($Modules)) {
    $moduleNames = $Modules.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries);
}
$moduleParams = @{
    Scope = 'CurrentUser'
    Force = $True
}
if ($PreRelease -eq 'true') {
    $moduleParams['AllowPrerelease'] = $True;
}

# Install each module if not already installed
foreach ($m in $moduleNames) {
    $m = $m.Trim();
    Write-Host "> Checking module: $m";
    try {
        if ($Null -eq (Get-InstalledModule -Name $m -ErrorAction Ignore)) {
            Write-Host '  - Installing module';
            $Null = Install-Module -Repository $Repository -Name $m @moduleParams -AllowClobber -SkipPublisherCheck -ErrorAction Stop;
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
    catch {
        Write-Host "`#`#vso[task.logissue type=error]$(Get-VstsLocString -Key 'DependencyFailed') $($_.Exception.Message)";
        Write-Host "`#`#vso[task.complete result=Failed;]FAILED";
        $Host.SetShouldExit(1);
    }
}

try {
    $checkParams = @{ MinimumVersion = $checkParams.RequiredVersion.Split('-')[0] }
    $Null = Import-Module PSRule @checkParams -ErrorAction Stop;
    $version = (Get-Module PSRule).Version;
}
catch {
    Write-Host "`#`#vso[task.logissue type=error]$(Get-VstsLocString -Key 'ImportFailed') $($_.Exception.Message)";
    Write-Host "`#`#vso[task.complete result=Failed;]FAILED";
    $Host.SetShouldExit(1);
}

$extensionFile = Join-Path -Path $PSScriptRoot -ChildPath 'version.json';
$extensionJson = Get-Content -Path $extensionFile -Raw -ErrorAction Stop | ConvertFrom-Json;
$extensionVersion = "$($extensionJson.version)";
$taskFile = Join-Path -Path $PSScriptRoot -ChildPath 'task.json';
$taskJson = Get-Content -Path $taskFile -Raw -ErrorAction Stop | ConvertFrom-Json;
$taskVersion = "$($taskJson.version.Major).$($taskJson.Version.Minor).$($taskJson.Version.Patch)";

Write-Host "`#`#[endgroup]";

#
# Run assert pipeline
#

Write-Host "`#`#[group]Checking environment";

Write-Host "[info] Using PSRule: $version"
Write-Host "[info] Using Extension: $extensionVersion"
Write-Host "[info] Using Task: $taskVersion"
Write-Host "[info] Using Workspace: $workspacePath"
Write-Host "[info] Using PWD: $PWD";
Write-Host "[info] Using Path: $Path";
Write-Host "[info] Using Source: $Source";
Write-Host "[info] Using Baseline: $Baseline";
Write-Host "[info] Using Conventions: $Conventions";
Write-Host "[info] Using InputType: $InputType";
Write-Host "[info] Using InputPath: $InputPath";
Write-Host "[info] Using Option: $Option";
Write-Host "[info] Using Outcome: $Outcome";
Write-Host "[info] Using OutputFormat: $OutputFormat";
Write-Host "[info] Using OutputPath: $OutputPath";

Write-Host "`#`#[endgroup]";

try {
    Push-Location -Path $Path;
    $invokeParams = @{
        Path = $Source
        Style = 'AzurePipelines'
        ErrorAction = 'Stop'
    }
    WriteDebug "Preparing command-line:";
    WriteDebug ([String]::Concat('-Path ''', $Source, ''''));
    if (![String]::IsNullOrEmpty($Baseline)) {
        $invokeParams['Baseline'] = $Baseline;
        WriteDebug ([String]::Concat('-Baseline ''', $Baseline, ''''));
    }
    if ($Conventions.Length -gt 0) {
        $invokeParams['Convention'] = $Conventions;
        WriteDebug ([String]::Concat('-Convention ', [String]::Join(', ', $Conventions)));
    }
    if (![String]::IsNullOrEmpty($Option)) {
        $invokeParams['Option'] = $Option;
        WriteDebug ([String]::Concat('-Option ', $Option));
    }
    if (![String]::IsNullOrEmpty($Outcome)) {
        $invokeParams['Outcome'] = $Outcome;
        WriteDebug ([String]::Concat('-Outcome ', $Outcome));
    }
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
catch [PSRule.Pipeline.RuleException] {
    Write-Host "`#`#vso[task.logissue type=error]$($_.Exception.Message)";
    Write-Host "$($_.Exception.ScriptStackTrace)";
    HostExit
}
catch [PSRule.Pipeline.FailPipelineException] {
    Write-Host "`#`#vso[task.logissue type=error]$(Get-VstsLocString -Key 'AssertFailed')";
    HostExit
}
catch {
    Write-Host "`#`#vso[task.logissue type=error]$($_.Exception.Message)";
    Write-Host "$($_.Exception.ScriptStackTrace)";
    HostExit
}
finally {
    Pop-Location;
}
Write-Host '---';
