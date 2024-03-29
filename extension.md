# PSRule

An Azure DevOps extension for using PSRule within Azure Pipelines.

## Disclaimer

If you have any problems please check our GitHub [issues] page.
If you do not see your problem captured, please file a new issue and follow the provided template.

## Getting started

The PSRule extension includes the following tasks for Azure Pipelines:

Name                | Friendly name   | Description | Reference
----                | -------------   | ----------- | ---------
`ps-rule-assert`    | PSRule analysis | Run analysis with PSRule. | [reference][ps-rule-assert]
`ps-rule-install`   | Install PSRule module | Install a PowerShell module containing rules. | [reference][ps-rule-install]

To add these tasks, use the name for YAML pipelines or friendly name of classic pipelines.

### Installing PSRule extension

To use PSRule within Azure DevOps Services, install the [extension] from the [Visual Studio Marketplace][extension].
For detailed instructions see [Install extensions][extension-install].

If you don't have permissions to install extensions within your Azure DevOps organization,
you can request it to be installed by an admin instead.

### Using within YAML pipelines

To use these tasks within YAML pipelines:

- Install rule modules with the `ps-rule-install` task (optional).
- Run analysis one or more times with the `ps-rule-assert` task.
- Publish analysis results with the [Publish Test Results](https://docs.microsoft.com/azure/devops/pipelines/tasks/test/publish-test-results?view=azure-devops&tabs=yaml) builtin task.

For example:

```yaml
steps:

# Install PSRule.Rules.Azure from the PowerShell Gallery
- task: ps-rule-install@2
  inputs:
    module: PSRule.Rules.Azure   # Install PSRule.Rules.Azure from the PowerShell Gallery.

# Run analysis from JSON files using the `PSRule.Rules.Azure` module and custom rules from `.ps-rule/`.
- task: ps-rule-assert@2
  inputs:
    modules: 'PSRule.Rules.Azure'            # Analyze objects using the rules within the PSRule.Rules.Azure PowerShell module.
    outputFormat: NUnit3                     # Save results to an NUnit report.
    outputPath: reports/ps-rule-results.xml  # Write NUnit report to 'reports/ps-rule-results.xml'.

# Publish NUnit report as test results
- task: PublishTestResults@2
  displayName: 'Publish PSRule results'
  inputs:
    testRunTitle: 'PSRule'                          # The title to use for the test run.
    testRunner: NUnit                               # Import report using the NUnit format.
    testResultsFiles: 'reports/ps-rule-results.xml' # The previously saved NUnit report.
```

## Changes and versioning

Extensions and tasks in this repository uses [semantic versioning](http://semver.org/) to declare breaking changes.
For a list of module changes please see the [change log].

## Contributing

This project welcomes contributions and suggestions.
If you are ready to contribute, please visit the [contribution guide].

## Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/)
or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Maintainers

- [Bernie White](https://github.com/BernieWhite)
- [Sam Bell](https://github.com/ms-sambell)

## License

This project is [licensed under the MIT License][license].

[issues]: https://github.com/Microsoft/PSRule-pipelines/issues
[extension]: https://marketplace.visualstudio.com/items?itemName=bewhite.ps-rule
[extension-install]: https://docs.microsoft.com/en-us/azure/devops/marketplace/install-extension?view=azure-devops&tabs=browser
[ps-rule-assert]: https://github.com/Microsoft/PSRule-pipelines/blob/main/docs/tasks.md#ps-rule-assert
[ps-rule-install]: https://github.com/Microsoft/PSRule-pipelines/blob/main/docs/tasks.md#ps-rule-install
[contribution guide]: https://github.com/Microsoft/PSRule-pipelines/blob/main/CONTRIBUTING.md
[change log]: https://github.com/Microsoft/PSRule-pipelines/blob/main/CHANGELOG.md
[license]: https://github.com/Microsoft/PSRule-pipelines/blob/main/LICENSE
