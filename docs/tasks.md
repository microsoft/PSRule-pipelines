# PSRule extension tasks

The following pipeline tasks are included in this extension.

## ps-rule-install

Use this task to install rule modules and their dependencies.
Modules will be installed to the current user scope.

```yaml
steps:
- task: ps-rule-install@0
  inputs:
    module: PSRule.Rules.Azure   # The name of a rule module to install.
    latest: false                # Optional. Determine if the installed module is updated to the latest version.
    prerelease: false            # Optional. Determine if a pre-release module version is installed.
    path: ''                     # Optional. The current working path for the task to execute from.
```

Inputs:

- **module**: The name of a rule module to install.
The module will be installed from the PowerShell Gallery.
For example: _PSRule.Rules.Azure_
- **latest**: Determine if the installed module is updated to the latest version.
- **prerelease**: Determine if a pre-release module version is installed.

## ps-rule-assert

Perform analysis and assert PSRule conditions.
Analysis can be perform from input files or the repository structure.

```yaml
steps:
- task: ps-rule-assert@0
  inputs:
    source: '.ps-rule/'
    inputType: inputPath
    inputPath: 'out/'
```

```yaml
steps:
- task: ps-rule-assert@0
  inputs:
    source: '.ps-rule/'
    inputType: repository
    outputType: NUnit3
    outputPath: reports/ps-rule-loopback.xml
```
