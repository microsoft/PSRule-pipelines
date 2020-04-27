# PSRule

An extension for using PSRule within Azure Pipelines.

![ci-badge]

This Azure DevOps extensions adds support for PSRule.

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
- Publish analysis results with the [Publish Test Results](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/test/publish-test-results?view=azure-devops&tabs=yaml) builtin task.

For example:

```yaml
steps:

# Install PSRule.Rules.Azure from the PowerShell Gallery
- task: ps-rule-install@0
  inputs:
    module: PSRule.Rules.Azure   # Install PSRule.Rules.Azure from the PowerShell Gallery.
    latest: false                # Only install the module if not already installed.
    prerelease: false            # Install stable versions only.

# Run analysis from JSON files using the `PSRule.Rules.Azure` module and custom rules from `.ps-rule/`.
- task: ps-rule-assert@0
  inputs:
    inputType: inputPath
    inputPath: 'out/*.json'                  # Read objects from JSON files in 'out/'.
    modules: 'PSRule.Rules.Azure'            # Analyze objects using the rules within the PSRule.Rules.Azure PowerShell module.
    source: '.ps-rule/'                      # Additionally, analyze object using custom rules from '.ps-rule/'.
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

Extensions and tasks in this repository will use the [semantic versioning](http://semver.org/) model to declare breaking changes from v1.0.0.
Prior to v1.0.0, breaking changes may be introduced in minor (0.x.0) version increments.
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

## License

This project is [licensed under the MIT License][license].

[issues]: https://github.com/Microsoft/PSRule-pipelines/issues
[ci-badge]: https://dev.azure.com/bewhite/PSRule-pipelines/_apis/build/status/PSRule-pipelines-CI?branchName=master
[extension]: https://marketplace.visualstudio.com/items?itemName=bewhite.ps-rule
[extension-install]: https://docs.microsoft.com/en-us/azure/devops/marketplace/install-extension?view=azure-devops&tabs=browser
[ps-rule-assert]: https://github.com/Microsoft/PSRule-pipelines/blob/master/docs/tasks.md#ps-rule-assert
[ps-rule-install]: https://github.com/Microsoft/PSRule-pipelines/blob/master/docs/tasks.md#ps-rule-install
[contribution guide]: https://github.com/Microsoft/PSRule-pipelines/blob/master/CONTRIBUTING.md
[change log]: https://github.com/Microsoft/PSRule-pipelines/blob/master/CHANGELOG.md
[license]: https://github.com/Microsoft/PSRule-pipelines/blob/master/LICENSE
