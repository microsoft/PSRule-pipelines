# Change log

## Unreleased

## v0.6.0

What's changed since v0.5.0:

- Engineering:
  - Updated to PSRule v0.21.0. [#72](https://github.com/microsoft/PSRule-pipelines/issues/72)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/CHANGELOG.md#v0210)

## v0.5.0

What's changed since v0.4.0:

- General improvements:
  - Updated `ps-rule-assert` task to use `File` input format for repository scans. [#45](https://github.com/microsoft/PSRule-pipelines/issues/45)
    - The `Input.PathIgnore` option can be configured to exclude files.
    - Path specs included in `.gitignore` are also automatically excluded.
- Engineering:
  - Updated to PSRule v0.20.0. [#54](https://github.com/microsoft/PSRule-pipelines/issues/54)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/CHANGELOG.md#v0200)

## v0.4.0

What's changed since v0.3.0:

- Engineering:
  - Updated to PSRule v0.19.0. [#31](https://github.com/microsoft/PSRule-pipelines/issues/31)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/CHANGELOG.md#v0190)

## v0.3.0

What's changed since v0.2.0:

- Engineering:
  - Updated to PSRule v0.18.0. [#24](https://github.com/microsoft/PSRule-pipelines/issues/24)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/CHANGELOG.md#v0180)

## v0.2.0

What's changed since v0.1.0:

- Engineering:
  - Updated to PSRule v0.17.0. [#19](https://github.com/microsoft/PSRule-pipelines/issues/19)
    - See the [change log](https://github.com/microsoft/PSRule/blob/main/CHANGELOG.md#v0170)
- Bug fixes:
  - Fixed examples in documentation referencing outputType instead of outputFormat. [#17](https://github.com/microsoft/PSRule-pipelines/issues/17)

## v0.1.0

- Initial release.
