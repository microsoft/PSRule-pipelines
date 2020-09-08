# Change log

## Unreleased

- General improvements:
  - Updated `ps-rule-assert` task to use `File` input format for repository scans. [#45](https://github.com/microsoft/PSRule-pipelines/issues/45)
    - The `Input.PathIgnore` option can be configured to exclude files.
    - Path specs included in `.gitignore` are also automatically excluded.
- Engineering:
  - Updated to PSRule v0.20.0. [#54](https://github.com/microsoft/PSRule-pipelines/issues/54)

## v0.4.0

What's changed since v0.3.0:

- Engineering:
  - Updated to PSRule v0.19.0. [#31](https://github.com/microsoft/PSRule-pipelines/issues/31)

## v0.3.0

What's changed since v0.2.0:

- Engineering:
  - Updated to PSRule v0.18.0. [#24](https://github.com/microsoft/PSRule-pipelines/issues/24)

## v0.2.0

What's changed since v0.1.0:

- Engineering:
  - Updated to PSRule v0.17.0. [#19](https://github.com/microsoft/PSRule-pipelines/issues/19)
- Bug fixes:
  - Fixed examples in documentation referencing outputType instead of outputFormat. [#17](https://github.com/microsoft/PSRule-pipelines/issues/17)

## v0.1.0

- Initial release.
