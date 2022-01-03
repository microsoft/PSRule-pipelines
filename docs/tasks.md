# PSRule extension tasks

The following pipeline tasks are included in this extension.

## ps-rule-install

Use this task to install rule modules and their dependencies.
Modules will be installed to the current user scope.

Syntax:

```yaml
steps:
- task: ps-rule-install@1
  inputs:
    module: string        # Required. The name of a rule module to install.
    latest: boolean       # Optional. Determine if the installed module is updated to the latest version.
    prerelease: boolean   # Optional. Determine if a pre-release module version is installed.
```

- **module**: The name of a rule module to install.
The module will be installed from the PowerShell Gallery.
For example: _PSRule.Rules.Azure_
- **latest**: Determine if the installed module is updated to the latest version.
- **prerelease**: Determine if a pre-release module version is installed.

### Example: Installing a rule module

Install the latest stable version of `PSRule.Rules.Azure` from the PowerShell Gallery if not already installed.

```yaml
steps:
- task: ps-rule-install@1
  inputs:
    module: PSRule.Rules.Azure   # Install PSRule.Rules.Azure from the PowerShell Gallery.
    latest: false                # Only install the module if not already installed.
    prerelease: false            # Install stable versions only.
```

## ps-rule-assert

Perform analysis and assert PSRule conditions.
Analysis can be perform from input files or the repository structure.

Syntax:

```yaml
steps:
- task: ps-rule-assert@1
  inputs:
    inputType: repository, inputPath                        # Required. Determines the type of input to use for PSRule.
    inputPath: string                                       # Required. The path PSRule will look for files to validate.
    modules: string                                         # Optional. A comma separated list of modules to use for analysis.
    baseline: string                                        # Optional. The name of a PSRule baseline to use.
    conventions: string                                     # Optional. A comma separated list of conventions to use.
    source: string                                          # Optional. An path containing rules to use for analysis.
    outputFormat: None, Yaml, Json, Markdown, NUnit3, Csv   # Optional. The format to use when writing results to disk.
    outputPath: string                                      # Optional. The file path to write results to.
    path: string                                            # Optional. The working directory PSRule is run from.
```

- **inputType**: Determines the type of input to use for PSRule.
Either `repository` or `inputPath`.
When `inputType: inputPath` is used, supported file formats within `inputPath` will be read as objects.
When `inputType: repository` is used, the structure of the repository will be analyzed instead.
- **inputPath**: Set the `inputPath` to determine where PSRule will look for input files.
When `inputType: inputPath` this is binds to the [-InputPath](https://microsoft.github.io/PSRule/commands/PSRule/en-US/Assert-PSRule.html#-inputpath) parameter.
When `inputType: repository` this will be the repository root that PSRule analyzes.
- **modules**: A comma separated list of modules to use for analysis.
Install PSRule modules using the `ps-rule-install` task.
If the modules have not been installed,
the latest stable version will be installed from the PowerShell Gallery automatically.
For example: _PSRule.Rules.Azure,PSRule.Rules.Kubernetes_
- **baseline**: The name of a PSRule baseline to use.
Baselines can be used from modules or specified in a separate file.
To use a baseline included in a module use `modules:` with `baseline:`.
To use a baseline specified in a separate file use `source:` with `baseline:`.
- **conventions**: A comma separated list of conventions to use.
Conventions can be used from modules or specified in a separate file.
For example: _Monitor.LogAnalytics.Import_
- **source**: An path containing rules to use for analysis.
Use this option to include rules not installed as a PowerShell module.
This binds to the [-Path](https://microsoft.github.io/PSRule/commands/PSRule/en-US/Assert-PSRule.html#-path) parameter.
- **outputFormat**: Output results can be written to disk in addition to the default output.
Use this option to determine the format to write results.
By default, results are not written to disk.
This binds to the [-OutputFormat](https://microsoft.github.io/PSRule/commands/PSRule/en-US/Assert-PSRule.html#-outputformat) parameter.
- **outputPath**: The file path to write results to.
This binds to the [-OutputPath](https://microsoft.github.io/PSRule/commands/PSRule/en-US/Assert-PSRule.html#-outputpath) parameter.
- **path**: The working directory PSRule is run from.
Options specified in `ps-rule.yaml` from this directory will be used unless overridden by inputs.

### Example: Run analysis from input files

Run analysis from JSON files using the `PSRule.Rules.Azure` module and custom rules from `.ps-rule/`.

```yaml
steps:
- task: ps-rule-assert@1
  inputs:
    inputType: inputPath
    inputPath: 'out/*.json'        # Read objects from JSON files in 'out/'.
    modules: 'PSRule.Rules.Azure'  # Analyze objects using the rules within the PSRule.Rules.Azure PowerShell module.
    source: '.ps-rule/'            # Additionally, analyze object using custom rules from '.ps-rule/'.
```

### Example: Run analysis of repository structure

Run analysis of the repository structure using the `PSRule.Rules.Azure` module.
Results are outputted to a NUnit format that can be published using the publish results task.

```yaml
steps:
- task: ps-rule-assert@1
  inputs:
    inputType: repository                    # Analyze repository structure.
    inputPath: $(BUILD_SOURCESDIRECTORY)     # Read repository structure from the default source path.
    modules: 'PSRule.Rules.Azure'            # Analyze objects using the rules within the PSRule.Rules.Azure PowerShell module.
    outputFormat: NUnit3                     # Save results to an NUnit report.
    outputPath: reports/ps-rule-results.xml  # Write NUnit report to 'reports/ps-rule-results.xml'.
```

### Example: Run analysis using an included baseline

Run analysis of files within `out/` and all subdirectories using the named baseline `Azure.GA_2021_06`.

```yaml
steps:
- task: ps-rule-assert@1
  inputs:
    inputType: inputPath
    inputPath: 'out/'              # Read objects from files in 'out/'.
    modules: 'PSRule.Rules.Azure'  # Analyze objects using the rules within the PSRule.Rules.Azure PowerShell module.
    baseline: 'Azure.GA_2021_06'   # Use the 'Azure.GA_2021_06' baseline included within PSRule.Rules.Azure.
    source: '.ps-rule/'            # Additionally, analyze object using custom rules from '.ps-rule/'.
```
