# PSRule extension for Azure Pipelines

An Azure DevOps extension for using PSRule within Azure Pipelines.

![ci-badge]

## Disclaimer

If you have any problems please check our GitHub [issues](https://github.com/BernieWhite/PSRule-pipelines/issues) page.
If you do not see your problem captured, please file a new issue and follow the provided template.

## Getting started

The PSRule extension includes the following tasks for Azure Pipelines:

Name                | Friendly name   | Description | Reference
----                | -------------   | ----------- | ---------
`ps-rule-assert`    | PSRule analysis | Run analysis with PSRule. | [reference][ps-rule-assert]
`ps-rule-install`   | Install PSRule module | Install PowerShell modules containing rules. | [reference][ps-rule-install]

To add these tasks, use the name for YAML pipelines or friendly name of classic pipelines.

### Pre-installing the PSRule module

A point in time release of PSRule is distributed with this extension.
To use pre-release versions or a newer version of PSRule use PowerShell to pre-install using:

```powershell
Install-Module -Name PSRule -Scope CurrentUser -Force;
```

Using YAML pipelines:

```yaml
steps:
- powershell: Install-Module -Name PSRule -Scope CurrentUser -Force;
```

### Using rules modules from PowerShell Gallery

To use rules modules, install them before using the `ps-rule-assert` task.
To install modules automatically from the PowerShell Gallery, use the `ps-rule-install` task.

Using YAML pipelines:

```yaml
steps:
- task: ps-rule-install@0
  inputs:
    modules: PSRule.Rules.Azure
```

### Using rules from Azure Artifacts

More to come.

### Assert repository structure

Using YAML pipelines:

```yaml
steps:
- task: ps-rule-assert@0
  inputs:
    source: '.ps-rule/'
    inputType: repository
```

### Assert an input path

Using YAML pipelines:

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

## Changes and versioning

Extensions and tasks in this repository will use the [semantic versioning](http://semver.org/) model to declare breaking changes from v1.0.0.
Prior to v1.0.0, breaking changes may be introduced in minor (0.x.0) version increments.
For a list of module changes please see the [change log](CHANGELOG.md).

## Contributing

This project welcomes contributions and suggestions.
If you are ready to contribute, please visit the [contribution guide](CONTRIBUTING.md).

## Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/)
or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Maintainers

- [Bernie White](https://github.com/BernieWhite)

## License

This project is [licensed under the MIT License](LICENSE).

[issues]: https://github.com/BernieWhite/PSRule-pipelines/issues
[ci-badge]: https://dev.azure.com/bewhite/PSRule-pipelines/_apis/build/status/PSRule-pipelines-CI?branchName=master
[extension]: https://marketplace.visualstudio.com/items?itemName=bewhite.ps-rule
[ps-rule-assert]: docs/tasks.md#ps-rule-assert
[ps-rule-install]: docs/tasks.md#ps-rule-install
