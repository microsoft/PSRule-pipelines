# Change log

See [upgrade notes][1] for helpful information when upgrading from previous versions.

**Important notes**:

- Node 6 extension handler will be removed from Azure DevOps _March 31st 2022_.
  To ensure your pipelines continue to work, please upgrade to the latest versions of the tasks.
  See [upgrade notes][1] for more information.
- Task versions `@0` and `@1` are deprecated and will be removed from _v3.0.0_.
  To ensure your pipelines continue to work, please upgrade to the latest versions of the tasks.
  See [upgrade notes][1] for more information.

  [1]: docs/upgrade-notes.md

## Unreleased

What's changed since v2.9.0:

- Engineering:
  - Bump VstsTaskSdk to v0.20.0.
    [#961](https://github.com/microsoft/PSRule-pipelines/pull/961)
  - Bump azure-pipelines-task-lib to v4.13.0.
    [#1006](https://github.com/microsoft/PSRule-pipelines/pull/1006)
  - Bump typescript to v5.5.4.
    [#1037](https://github.com/microsoft/PSRule-pipelines/pull/1037)
  - Bump Pester to v5.5.0.
    [#842](https://github.com/microsoft/PSRule-pipelines/pull/842)
  - Bump tfx-cli to v0.17.0.
    [#968](https://github.com/microsoft/PSRule-pipelines/pull/968)

## v2.9.0

What's changed since v2.8.1:

- Engineering:
  - Bump PSRule to v2.9.0.
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v290)
  - Bump typescript to v5.1.3.
    [#806](https://github.com/microsoft/PSRule-pipelines/pull/806)

## v2.8.1

What's changed since v2.8.0:

- Engineering:
  - Bump PSRule to v2.8.1.
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v281)

## v2.8.0

What's changed since v2.7.0:

- New features:
  - Added job summaries to each run by @BernieWhite.
    [#724](https://github.com/microsoft/PSRule-pipelines/issues/724)
    - Set the `summary` input to `false` to skip generating a job summary.
- General improvements:
  - **Important change**: Added warning to V1 tasks and update V0 tasks by @BernieWhite.
    [#694](https://github.com/microsoft/PSRule-pipelines/issues/694)
    - Deprecated task versions `@0` and `@1` will be removed from _v3.0.0_.
    - Upgrade to `@2` task versions to ensure your pipelines continue to work.
  - Updated Node 10 tasks to require minimum agent version by @BernieWhite.
    [#692](https://github.com/microsoft/PSRule-pipelines/issues/692)
  - Updated V2 tasks to support Node 16 by @BernieWhite.
    [#693](https://github.com/microsoft/PSRule-pipelines/issues/693)
- Engineering:
  - Bump PSRule to v2.8.0.
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v280)
  - Bump azure-pipelines-task-lib to v4.3.1.
    [#741](https://github.com/microsoft/PSRule-pipelines/pull/741)
  - Bump Pester to v5.4.0.
    [#666](https://github.com/microsoft/PSRule-pipelines/pull/666)
  - Bump typescript to v5.0.2.
    [#736](https://github.com/microsoft/PSRule-pipelines/pull/736)
- Bug fixes:
  - Fixed summary with job summary by @BernieWhite.
    [#750](https://github.com/microsoft/PSRule-pipelines/issues/750)

## v2.7.0

What's changed since v2.6.0:

- Engineering:
  - Bump PSRule to v2.7.0.
    [#657](https://github.com/microsoft/PSRule-pipelines/pull/657)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v270)
  - Bump typescript to v4.9.4.
    [#627](https://github.com/microsoft/PSRule-pipelines/pull/627)
  - Bump azure-pipelines-task-lib to v4.1.0.
    [#620](https://github.com/microsoft/PSRule-pipelines/pull/620)

## v2.6.0

What's changed since v2.5.2:

- Engineering:
  - Bump PSRule to v2.6.0.
    [#606](https://github.com/microsoft/PSRule-pipelines/pull/606)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v260)
  - Bump typescript to v4.9.3.
    [#603](https://github.com/microsoft/PSRule-pipelines/pull/603)

## v2.5.2

What's changed since v2.5.1:

- Engineering:
  - Bump PSRule to v2.5.3.
    [#581](https://github.com/microsoft/PSRule-pipelines/pull/581)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v253)
- Bug fixes:
  - Fixed stale task versioning by @BernieWhite.
    [#589](https://github.com/microsoft/PSRule-pipelines/issues/589)

## v2.5.1

What's changed since v2.5.0:

- Engineering:
  - Bump PSRule to v2.5.1.
    [#569](https://github.com/microsoft/PSRule-pipelines/pull/569)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v251)

## v2.5.0

What's changed since v2.4.2:

- General improvements:
  - Added outcome filtering parameter by @BernieWhite.
    [#570](https://github.com/microsoft/PSRule-pipelines/issues/570)
- Engineering:
  - Bump typescript to v4.8.4.
    [#546](https://github.com/microsoft/PSRule-pipelines/pull/546)
  - Bump PSRule to v2.5.0.
    [#560](https://github.com/microsoft/PSRule-pipelines/pull/560)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v250)
  - Bump PSScriptAnalyzer to v1.21.0.
    [#560](https://github.com/microsoft/PSRule-pipelines/pull/560)

## v2.4.2

What's changed since v2.4.1:

- Engineering:
  - Bump PSRule to v2.4.2.
    [#553](https://github.com/microsoft/PSRule-pipelines/pull/553)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v242)

## v2.4.1

What's changed since v2.4.0:

- Engineering:
  - Bump PSRule to v2.4.1.
    [#548](https://github.com/microsoft/PSRule-pipelines/pull/548)
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v241)

## v2.4.0

What's changed since v2.3.0:

- Engineering:
  - Bump PSRule to v2.4.0.
    [#518](https://github.com/microsoft/PSRule-pipelines/pull/518)
    - See the [change log](https://microsoft.github.io/PSRule/latest/CHANGELOG-v2/#v240)
  - Bump typescript to v4.8.3.
    [#527](https://github.com/microsoft/PSRule-pipelines/pull/527)

## v2.3.0

What's changed since v2.2.0:

- Engineering:
  - Bump PSRule to v2.3.2.
    [#498](https://github.com/microsoft/PSRule-pipelines/pull/498)
    - See the [change log](https://microsoft.github.io/PSRule/latest/CHANGELOG-v2/#v232)
  - Bump typescript to v4.8.2.
    [#514](https://github.com/microsoft/PSRule-pipelines/pull/514)

## v2.2.0

What's changed since v2.1.0:

- General improvements:
  - Improved display of extension version in output by @BernieWhite.
    [#386](https://github.com/microsoft/PSRule-pipelines/issues/386)
- Engineering:
  - Bump PSRule to v2.2.0.
    [#467](https://github.com/microsoft/PSRule-pipelines/pull/467)
    - See the [change log](https://microsoft.github.io/PSRule/latest/CHANGELOG-v2/#v220)

## v2.1.0

What's changed since v2.0.1:

- New features:
  - Added support for alternative option file by @BernieWhite.
    [#349](https://github.com/microsoft/PSRule-pipelines/issues/349)
    - Set the option parameter to the path to an options file.
    - By default, the ps-rule.yaml option file is used.
- Engineering:
  - Bump azure-pipelines-task-lib to v3.3.1.
    [#418](https://github.com/microsoft/PSRule-pipelines/pull/418)
  - Bump PSRule to v2.1.0.
    [#446](https://github.com/microsoft/PSRule-pipelines/pull/446)
    - See the [change log](https://microsoft.github.io/PSRule/latest/CHANGELOG-v2/#v210)

## v2.0.1

What's changed since v2.0.0:

- Bug fixes:
  - Fixes file not found error when running task by @BernieWhite.
    [#411](https://github.com/microsoft/PSRule-pipelines/issues/411)

## v2.0.0

What's changed since v1.5.0:

- New features:
  - Added tasks for PSRule v2 support by @BernieWhite.
    [#312](https://github.com/microsoft/PSRule-pipelines/issues/312)
    - Added `ps-rule-assert@2` task.
    - Added `ps-rule-install@2` task.
    - See the [change log](https://microsoft.github.io/PSRule/v2/CHANGELOG-v2/#v200)
  - Added support for outputting analysis results as SARIF by @BernieWhite.
    [#315](https://github.com/microsoft/PSRule-pipelines/issues/315)
    - To use the SARIF output format set the `outputFormat` parameter to `Sarif`.
    - Currently a pre-release version of PSRule must be used.
  - Added the ability to use a specific version of PSRule by @BernieWhite.
    [#314](https://github.com/microsoft/PSRule-pipelines/issues/314)
    - To install a specific version set the version parameter.
    - By default, the latest stable version of PSRule is used.
  - Added the ability to use an alternative PowerShell repository by @BernieWhite.
    [#353](https://github.com/microsoft/PSRule-pipelines/issues/353)
    - Register and authenticate to the repository in PowerShell if required.
    - Configure repository to install modules from the named repository.
- General improvements:
  - Expose more rule error output in CI by @ArmaanMcleod.
    [#308](https://github.com/microsoft/PSRule-pipelines/issues/308)
- Engineering:
  - Flagged v0 tasks as deprecated by @BernieWhite.
    [#399](https://github.com/microsoft/PSRule-pipelines/issues/399)
- Bug fixes:
  - Fixed failure loading VstsTaskSdk by @BernieWhite.
    [#361](https://github.com/microsoft/PSRule-pipelines/issues/361)
  - Fixed handling of unset path by @BernieWhite.
    [#363](https://github.com/microsoft/PSRule-pipelines/issues/363)
  - Fixed dependency conflict with older module versions by @BernieWhite.
    [#396](https://github.com/microsoft/PSRule-pipelines/issues/396)

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
    - See the [change log](https://microsoft.github.io/PSRule/latest/CHANGELOG-v1/#v1110)

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
