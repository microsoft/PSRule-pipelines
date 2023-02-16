// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// Configuration script for extension

module.exports = (env) => {
  let [publisher, idPrefix] = (env.official == "true") ? ["ps-rule", "pipelines"] : ["bewhite", "ps-rule"];
  let version = env.version;

  let [idPostfix, namePostfix] = (env.channel == "stable") ? ["", ""] : ["-dev", " [DEV]"];
  if (env.channel == "canary") {
    idPostfix = "-canary";
    namePostfix = " [CANARY]";
  }
  else if (env.channel == "preview") {
    idPostfix = "-preview";
    namePostfix = " [PREVIEW]";
  }

  let manifest = {
    manifestVersion: 1,
    id: `${idPrefix}${idPostfix}`,
    name: `PSRule${namePostfix}`,
    version: version,
    publisher: publisher,
    targets: [
      { id: "Microsoft.VisualStudio.Services" },
    ],
    description: "An extension for using PSRule within Azure Pipelines.",
    public: false,
    categories: ["Azure Pipelines"],
    branding: {
      theme: "dark",
      color: "#0072c6"
    },
    icons: {
      default: "images/icon128.png"
    },
    content: {
      details: {
        path: "extension.md"
      },
      license: {
        path: "LICENSE"
      }
    },
    links: {
      home: {
        uri: "https://github.com/microsoft/PSRule-pipelines"
      },
      repository: {
        uri: "https://github.com/microsoft/PSRule-pipelines"
      },
      issues: {
        uri: "https://github.com/microsoft/PSRule-pipelines/issues"
      }
    },
    repository: {
      type: "git",
      url: "https://github.com/microsoft/PSRule-pipelines"
    },
    files: [
      {
        path: "images/icon128.png",
        packagePath: "/images/icon128.png"
      },
      {
        path: "out/dist/ps-rule-assert",
        packagePath: "/ps-rule-assert"
      },
      {
        path: "out/dist/ps-rule-install",
        packagePath: "/ps-rule-install"
      },
      {
        path: "out/dist/ps_modules/PSRule/1.11.1",
        packagePath: "/ps-rule-assert/ps-rule-assertV0/ps_modules/PSRule/1.11.1"
      },
      {
        path: "out/dist/ps_modules/VstsTaskSdk/0.11.0",
        packagePath: "/ps-rule-assert/ps-rule-assertV0/ps_modules/VstsTaskSdk"
      },
      {
        path: "out/dist/ps_modules/PowerShellGet",
        packagePath: "/ps-rule-install/ps-rule-installV0/ps_modules/PowerShellGet"
      },
      {
        path: "out/dist/ps_modules/PackageManagement",
        packagePath: "/ps-rule-install/ps-rule-installV0/ps_modules/PackageManagement"
      },
      {
        path: "out/dist/ps_modules/VstsTaskSdk/0.11.0",
        packagePath: "/ps-rule-install/ps-rule-installV0/ps_modules/VstsTaskSdk"
      },
      {
        path: "out/dist/ps_modules/PSRule/1.11.1",
        packagePath: "/ps-rule-assert/ps-rule-assertV1/ps_modules/PSRule/1.11.1"
      },
      {
        path: "out/dist/ps_modules/VstsTaskSdk/0.11.0",
        packagePath: "/ps-rule-assert/ps-rule-assertV1/ps_modules/VstsTaskSdk"
      },
      {
        path: "out/dist/ps_modules/PowerShellGet",
        packagePath: "/ps-rule-install/ps-rule-installV1/ps_modules/PowerShellGet"
      },
      {
        path: "out/dist/ps_modules/PackageManagement",
        packagePath: "/ps-rule-install/ps-rule-installV1/ps_modules/PackageManagement"
      },
      {
        path: "out/dist/ps_modules/VstsTaskSdk/0.11.0",
        packagePath: "/ps-rule-install/ps-rule-installV1/ps_modules/VstsTaskSdk"
      },
      {
        path: "out/dist/modules.json",
        packagePath: "/ps-rule-assert/ps-rule-assertV2/modules.json"
      },
      {
        path: "out/dist/version.json",
        packagePath: "/ps-rule-assert/ps-rule-assertV2/version.json"
      },
      {
        path: "out/dist/ps_modules/PSRule/2.7.0",
        packagePath: "/ps-rule-assert/ps-rule-assertV2/ps_modules/PSRule/2.7.0"
      },
      {
        path: "out/dist/ps_modules/VstsTaskSdk/0.11.0",
        packagePath: "/ps-rule-assert/ps-rule-assertV2/ps_modules/VstsTaskSdk"
      },
      {
        path: "out/dist/ps_modules/PowerShellGet",
        packagePath: "/ps-rule-install/ps-rule-installV2/ps_modules/PowerShellGet"
      },
      {
        path: "out/dist/ps_modules/PackageManagement",
        packagePath: "/ps-rule-install/ps-rule-installV2/ps_modules/PackageManagement"
      },
      {
        path: "out/dist/ps_modules/VstsTaskSdk/0.11.0",
        packagePath: "/ps-rule-install/ps-rule-installV2/ps_modules/VstsTaskSdk"
      }
    ],
    contributions: [
      {
        id: "assert",
        type: "ms.vss-distributed-task.task",
        targets: [
          "ms.vss-distributed-task.tasks"
        ],
        properties: {
          name: "ps-rule-assert"
        }
      },
      {
        id: "install",
        type: "ms.vss-distributed-task.task",
        targets: [
          "ms.vss-distributed-task.tasks"
        ],
        properties: {
          name: "ps-rule-install"
        }
      }
    ],
    CustomerQnASupport: {
      enableqna: false
    },
  }

  return manifest;
}
