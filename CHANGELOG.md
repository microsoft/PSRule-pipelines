# Change log

See [upgrade notes][1] for helpful information when upgrading from previous versions.

**Important notes**:

- Node 6 extension handler will be removed from Azure DevOps _March 31st 2022_.
  To ensure your pipelines continue to work, please upgrade to the latest versions of the tasks.
  See [upgrade notes][1] for more information.

  [1]: docs/upgrade-notes.md

## Unreleased

What's changed since v1.5.0:

- General improvements:
  - Expose more rule error output in CI. [#308](https://github.com/microsoft/PSRule-pipelines/issues/308)
- New features:
  - Added support for outputting analysis results as SARIF. [#315](https://github.com/microsoft/PSRule-pipelines/issues/315)
    - To use the SARIF output format set the `outputFormat` parameter to `Sarif`.
    - Currently a pre-release version of PSRule must be used.
- Engineering:
  - Preparing for PSRule v2 support. [#312](https://github.com/microsoft/PSRule-pipelines/issues/312)
    - Added `ps-rule-assert@2` task for PSRule v2.
    - Added `ps-rule-install@2` task for PSRule v2.

## v1.5.0

What's changed since v1.4.0:

- Engineering:
  - Update extension icon to the latest version. [#279](https://github.com/microsoft/PSRule-pipelines/issues/279)
  - Update node execution handler to Node 10. [#265](https://github.com/microsoft/PSRule-pipelines/issues/265)
    - Added `ps-rule-assert@1` task that uses Node 10 extension handler.
    - Added `ps-rule-install@1` task that uses Node 10 extension handler.
    - Please upgrade your pipelines to the latest task versions to avoid issues.
    - Added warning to older task versions to ensure they are upgraded.
  - Bump PSRule dependency to v1.11.0. [#278](https://github.com/microsoft/PSRule-pipelines/issues/278)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v1110).

## v1.4.0

What's changed since v1.3.0:

- Engineering:
  - Bump PSRule dependency to v1.9.0. [#256](https://github.com/microsoft/PSRule-pipelines/issues/256)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v190).

## v1.3.0

What's changed since v1.2.1:

- Engineering:
  - Bump PSRule dependency to v1.8.0. [#241](https://github.com/microsoft/PSRule-pipelines/issues/241)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v180).
  - Bump azure-pipelines-task-lib from 3.1.10 [#242](https://github.com/microsoft/PSRule-pipelines/pull/242)

## v1.2.1

What's changed since v1.2.0:

- Engineering:
  - Bump PSRule dependency to v1.7.2. [#231](https://github.com/microsoft/PSRule-pipelines/issues/231)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v172).

## v1.2.0

What's changed since v1.1.1:

- General improvements:
  - Added support for conventions. [#211](https://github.com/microsoft/PSRule-pipelines/issues/211)
    - Specify one or more conventions by using `conventions: '<convention1>,<convention2>'`.
    - Conventions can be included from individual files or modules using `source:` and `modules:`.
- Engineering:
  - Bump PSRule dependency to v1.7.0. [#223](https://github.com/microsoft/PSRule-pipelines/issues/223)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v170).
  - Bump azure-pipelines-task-lib to 3.1.9. [#221](https://github.com/microsoft/PSRule-pipelines/pull/221)

## v1.1.1

What's changed since v1.1.0:

- Engineering:
  - Bump azure-pipelines-task-lib to 3.1.7. [#206](https://github.com/microsoft/PSRule-pipelines/pull/206)

## v1.1.0

What's changed since v1.0.0:

- Engineering:
  - Bump PSRule dependency to v1.6.0. [#200](https://github.com/microsoft/PSRule-pipelines/issues/200)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v160).
  - Bump azure-pipelines-task-lib to 3.1.6. [#195](https://github.com/microsoft/PSRule-pipelines/pull/195)
- Bug fixes:
  - Fixed assert task to ensure it fails when a dependency module installation fails. [#202](https://github.com/microsoft/PSRule-pipelines/issues/202)

## v1.0.0

What's changed since v0.9.0:

- Engineering:
  - Bump PSRule dependency to v1.4.0. [#163](https://github.com/microsoft/PSRule-pipelines/issues/163)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v140).
  - Bump azure-pipelines-task-lib to 3.1.2. [#147](https://github.com/microsoft/PSRule-pipelines/pull/147)

## v0.9.0

What's changed since v0.8.0:

- Engineering:
  - Bump PSRule dependency to v1.2.0. [#139](https://github.com/microsoft/PSRule-pipelines/issues/139)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v120).
  - Bump azure-pipelines-task-lib to 3.1.0. [#123](https://github.com/microsoft/PSRule-pipelines/pull/123)

## v0.8.0

What's changed since v0.7.0:

- General improvements:
  - Added support for using baselines. [#46](https://github.com/microsoft/PSRule-pipelines/issues/46)
    - Specify a named baseline by using `baseline: '<baseline_name>'`.
    - Baselines can be included from individual files or modules using `source:` and `modules:`.
  - Added support for markdown output format. [#114](https://github.com/microsoft/PSRule-pipelines/issues/114)
- Engineering:
  - Bump PSRule dependency to v1.0.1. [#106](https://github.com/microsoft/PSRule-pipelines/issues/106)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v101).

## v0.7.0

What's changed since v0.6.0:

- Engineering:
  - Bump PSRule dependency to v1.0.0. [#82](https://github.com/microsoft/PSRule-pipelines/issues/82)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v1.md#v100).

## v0.6.0

What's changed since v0.5.0:

- Engineering:
  - Bump PSRule dependency to v0.21.0. [#72](https://github.com/microsoft/PSRule-pipelines/issues/72)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v0.md#v0210).

## v0.5.0

What's changed since v0.4.0:

- General improvements:
  - **Breaking change**: Updated `ps-rule-assert` task to use `File` input format for repository scans. [#45](https://github.com/microsoft/PSRule-pipelines/issues/45)
    - The `Input.PathIgnore` option can be configured to exclude files.
    - Path specs included in `.gitignore` are also automatically excluded.
    - See [upgrade notes][upgrade-v0.5.0] for details on breaking change.
- Engineering:
  - Bump PSRule dependency to v0.20.0. [#54](https://github.com/microsoft/PSRule-pipelines/issues/54)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v0.md#v0200).

See [upgrade notes][upgrade-v0.5.0] for helpful information when upgrading from previous versions.

[upgrade-v0.5.0]: docs/upgrade-notes.md#upgrade-to-v040-from-v050

## v0.4.0

What's changed since v0.3.0:

- Engineering:
  - Bump PSRule dependency to v0.19.0. [#31](https://github.com/microsoft/PSRule-pipelines/issues/31)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v0.md#v0190).

## v0.3.0

What's changed since v0.2.0:

- Engineering:
  - Bump PSRule dependency to v0.18.0. [#24](https://github.com/microsoft/PSRule-pipelines/issues/24)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v0.md#v0180).

## v0.2.0

What's changed since v0.1.0:

- Engineering:
  - Bump PSRule dependency to v0.17.0. [#19](https://github.com/microsoft/PSRule-pipelines/issues/19)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/docs/CHANGELOG-v0.md#v0170).
- Bug fixes:
  - Fixed examples in documentation referencing outputType instead of outputFormat. [#17](https://github.com/microsoft/PSRule-pipelines/issues/17)

## v0.1.0

- Initial release.
