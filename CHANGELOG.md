# Change log

See [upgrade notes][upgrade-notes] for helpful information when upgrading from previous versions.

[upgrade-notes]: docs/upgrade-notes.md

## Unreleased

- General improvements:
  - Added support for conventions. [#211](https://github.com/microsoft/PSRule-pipelines/issues/211)
    - Specify one or more conventions by using `conventions: '<convention1>,<convention2>'`.
    - Conventions can be included from individual files or modules using `source:` and `modules:`.

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
