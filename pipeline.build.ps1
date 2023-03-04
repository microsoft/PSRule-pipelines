# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

[CmdletBinding()]
param (
    [Parameter(Mandatory = $False)]
    [String]$Build = '0.0.1',

    [Parameter(Mandatory = $False)]
    [String]$Rev = '0',

    [Parameter(Mandatory = $False)]
    [String]$ExtensionTag = '',

    [Parameter(Mandatory = $False)]
    [String]$Configuration = 'Debug'
)

Write-Host -Object "[Pipeline] -- PWD: $PWD" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- BuildNumber: $($Env:BUILD_BUILDNUMBER)" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- SourceBranch: $($Env:BUILD_SOURCEBRANCH)" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- SourceBranchName: $($Env:BUILD_SOURCEBRANCHNAME)" -ForegroundColor Green;

if ($Env:SYSTEM_DEBUG -eq 'true') {
    $VerbosePreference = 'Continue';
}

$version = $Build;
if ($Env:BUILD_SOURCEBRANCH -like '*/tags/*' -and $Env:BUILD_SOURCEBRANCHNAME -like 'v2.*') {
    $version = $Env:BUILD_SOURCEBRANCHNAME.Substring(1);
}

$versionSuffix = [String]::Empty;

if ($version -like '*-*') {
    [String[]]$versionParts = $version.Split('-', [System.StringSplitOptions]::RemoveEmptyEntries);
    $version = $versionParts[0];

    if ($versionParts.Length -eq 2) {
        $versionSuffix = $versionParts[1];
    }
}

Write-Host -Object "[Pipeline] -- Using version: $version" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- Using versionSuffix: $versionSuffix" -ForegroundColor Green;

# A list of tasks included in the extension
$tasks = @((Get-ChildItem -Path tasks/ -Directory).Name)

# Copy the extension files to the destination path
function CopyExtensionFiles {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [String]$Path,

        [Parameter(Mandatory = $True)]
        [String]$DestinationPath
    )
    process {
        $sourcePath = Resolve-Path -Path $Path;
        Get-ChildItem -Path $sourcePath -File -Include *.ps1,*.json,*.png -Recurse | Where-Object {
            ($_.FullName -notmatch '(\\|\/)(node_modules)') -and
            ($_.FullName -notcontains 'package.json')
        } | ForEach-Object {
            $filePath = $_.FullName.Replace($sourcePath, $DestinationPath);
            $parentPath = Split-Path -Path $filePath -Parent;
            if (!(Test-Path -Path $parentPath)) {
                $Null = New-Item -Path $parentPath -ItemType Directory -Force;
            }
            Copy-Item -Path $_.FullName -Destination $filePath -Force;
        };
    }
}

function UpdateTaskVersion {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [String]$Path
    )
    process {
        $v = $Build.Split('.', [System.StringSplitOptions]::RemoveEmptyEntries);
        $taskVersion = $v[2];
        Write-Host "Using task version: $taskVersion"
        Get-ChildItem -Path $Path -Filter task.json -Recurse | ForEach-Object {
            $filePath = $_.FullName;
            $taskContent = Get-Content -Raw -Path $filePath | ConvertFrom-Json;
            $taskContent.version.Patch = $taskVersion;
            $taskContent | ConvertTo-Json -Depth 100 | Set-Content -Path $filePath -Force;
        }
    }
}

# Synopsis: Install NuGet provider
task NuGet {
    if ($Null -eq (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name NuGet -Force -Scope CurrentUser;
    }
}

task Dependencies NuGet, {
    Import-Module $PWD/scripts/dependencies.psm1;
    Install-Dependencies -Path $PWD/modules.json;
}

task SaveDependencies NuGet, PSRule, {
    Import-Module $PWD/scripts/dependencies.psm1;
    Save-Dependencies -Path $PWD/modules.json -OutputPath out/dist/ps_modules;
}

# Synopsis: Install PSRule older version of PSRule for V1
task PSRule NuGet, {
    if (!(Test-Path -Path out/dist/ps_modules)) {
        $Null = New-Item -Path out/dist/ps_modules -ItemType Directory -Force;
    }
    if ($Null -eq (Get-InstalledModule -Name PSRule -RequiredVersion 1.11.1 -ErrorAction SilentlyContinue)) {
        Install-Module -Name PSRule -Repository PSGallery -Scope CurrentUser -RequiredVersion 1.11.1 -Force;
    }
    Save-Module -Name PSRule -Repository PSGallery -Path out/dist/ps_modules -RequiredVersion 1.11.1;
    Import-Module -Name PSRule -Verbose:$False;
}

# Synopsis: Remove temp files.
task Clean {
    Remove-Item -Path out,reports -Recurse -Force -ErrorAction SilentlyContinue;
}

task CopyExtension {
    Write-Host '> Copy extension' -ForegroundColor Green;

    foreach ($task in $tasks) {
        $taskRoot = $task.Split('V')[0];
        CopyExtensionFiles -Path "tasks/$task" -DestinationPath "out/dist/$taskRoot/$task/";
        Copy-Item -Path images/icon128.png -Destination "out/dist/$taskRoot/$task/icon.png" -Force;
        
        Push-Location "out/dist/$taskRoot/$task/";
        exec { & npm init --force }
        exec { & npm install shelljs }
        Pop-Location;
    }

    # Copy manifests
    Copy-Item -Path modules.json -Destination out/dist/;

    # Copy icon
    if (!(Test-Path -Path out/dist/images)) {
        $Null = New-Item -Path out/dist/images -ItemType Directory -Force;
    }
    Copy-Item -Path images/icon128.png -Destination out/dist/images/ -Force;

    # Copy repo files
    Copy-Item -Path extension.md -Destination out/dist/;
    Copy-Item -Path CHANGELOG.md -Destination out/dist/;
    Copy-Item -Path LICENSE -Destination out/dist/;
}

task BuildExtension CopyExtension, VersionExtension, SaveDependencies, {
    Write-Host '> Building extension' -ForegroundColor Green;
    exec { & npm run build }
    exec { & npm run -S "package" -- --env version=$Build }
    exec { & npm run -S "package" -- --env version=$Build official=true }
}

task VersionExtension {
    Write-Host '> Version extension' -ForegroundColor Green;

    # Update module version
    if (![String]::IsNullOrEmpty($version)) {
        Write-Verbose -Message "[VersionExtension] -- Updating extension manifest version";

        # Write version info
        if (!(Test-Path -Path out/dist)) {
            $Null = New-Item -Path out/dist -ItemType Directory -Force;
        }
        $versionInfo = Join-Path -Path out/dist/ -ChildPath 'version.json';
        @{ version = $version } | ConvertTo-Json | Set-Content -Path $versionInfo;
    }

    UpdateTaskVersion -Path out/dist/;
}

# Synopsis: This task reads version info if set and configures a build variable
task GetVersionInfo {
    $baseVersion = dotnet-gitversion /showvariable MajorMinorPatch /nofetch;
    if (![String]::IsNullOrEmpty($ExtensionTag)) {
        $commits = dotnet-gitversion /showvariable CommitsSinceVersionSource /nofetch;
        $baseVersion = (Get-Date).ToString("yyyy.M.$commits");
    }

    Write-Host "[Pipeline] Using EXTENSION_VERSION: $baseVersion";
    Write-Host "`#`#vso[task.setvariable variable=EXTENSION_VERSION;]$baseVersion";

    $taskVersionParts = (dotnet-gitversion /showvariable MajorMinorPatch /nofetch).Split('.', [System.StringSplitOptions]::RemoveEmptyEntries);
    $taskVersion = "$($taskVersionParts[0]).$($taskVersionParts[1]).$Rev";

    Write-Host "`#`#vso[build.updatebuildnumber]$taskVersion";
}

# Synopsis: Run validation
task Rules Dependencies, {
    $assertParams = @{
        OutputFormat = 'NUnit3'
        ErrorAction = 'Stop'
        Format = 'File'
        InputPath = '.'
    }
    Assert-PSRule @assertParams -OutputPath reports/ps-rule-file.xml;
}

task TestModule Dependencies, {
    # Run Pester tests
    $pesterOptions = @{
        Run        = @{
            Path     = (Join-Path -Path $PWD -ChildPath tests/);
            PassThru = $True;
        };
        TestResult = @{
            Enabled      = $True;
            OutputFormat = 'NUnitXml';
            OutputPath   = 'reports/pester-unit.xml';
        };
    };

    if ($CodeCoverage) {
        $codeCoverageOptions = @{
            Enabled    = $True;
            OutputPath = (Join-Path -Path $PWD -ChildPath 'reports/pester-coverage.xml');
            Path       = (Join-Path -Path $PWD -ChildPath 'tasks/**/*.ps1');
        };

        $pesterOptions.Add('CodeCoverage', $codeCoverageOptions);
    }

    if (!(Test-Path -Path reports)) {
        $Null = New-Item -Path reports -ItemType Directory -Force;
    }

    if ($Null -ne $TestGroup) {
        $pesterOptions.Add('Filter', @{ Tag = $TestGroup });
    }

    # https://pester.dev/docs/commands/New-PesterConfiguration
    $pesterConfiguration = New-PesterConfiguration -Hashtable $pesterOptions;

    $results = Invoke-Pester -Configuration $pesterConfiguration;

    # Throw an error if pester tests failed
    if ($Null -eq $results) {
        throw 'Failed to get Pester test results.';
    }
    elseif ($results.FailedCount -gt 0) {
        throw "$($results.FailedCount) tests failed.";
    }
}

# Synopsis: Restore NPM packages
task PackageRestore {
    exec { & npm install --no-save }
}

# Synopsis: Build and clean.
task . Build, Rules

# Synopsis: Build the project
task Build Clean, PackageRestore, BuildExtension

task Test Build, TestModule
