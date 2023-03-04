// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import * as fs from 'fs';
import * as path from 'path';
import * as os from 'os';
import * as task from 'azure-pipelines-task-lib/task';
import * as runner from 'azure-pipelines-task-lib/toolrunner';

async function run() {
    try {
        // Get task
        task.setResourcePath(path.join(__dirname, 'task.json'));

        // Get inputs
        let input_module: string = task.getInput('module', /*required*/ true);
        let input_latest: boolean = task.getBoolInput('latest', /*required*/ true);
        let input_prerelease: boolean = task.getBoolInput('prerelease', /*required*/ true);

        // Write bootstrap commands to a temporary script file
        let contents: string[] = [];

        // Import SDK
        contents.push(`$rootPath = '${__dirname}';`);
        contents.push(`$sdkPath = Join-Path -Path $rootPath -ChildPath 'ps_modules/VstsTaskSdk';`);
        contents.push(`Import-Module $sdkPath -ArgumentList @{ NonInteractive = 'true' }`);

        // Prepare parameters
        contents.push(`$scriptParams = @{ };`);
        if (input_module !== undefined) {
            contents.push(`$scriptParams['Module'] = '${input_module}'`);
        }
        if (input_latest) {
            contents.push(`$scriptParams['Latest'] = $True;`);
        }
        else {
            contents.push(`$scriptParams['Latest'] = $False;`);
        }
        if (input_prerelease) {
            contents.push(`$scriptParams['PreRelease'] = $True;`);
        }
        else {
            contents.push(`$scriptParams['PreRelease'] = $False;`);
        }

        // Add PowerShell entry point
        contents.push(` . $rootPath\\powershell.ps1 @scriptParams`.trim());

        // Write the script to disk.
        task.assertAgent('2.144.0');
        const tempDirectory = task.getVariable('agent.tempDirectory');
        task.checkPath(tempDirectory, `${tempDirectory} (agent.tempDirectory)`);
        const filePath = path.join(tempDirectory, 'run_ps_rule_install.ps1');
        fs.writeFileSync(filePath, '\ufeff' + contents.join(os.EOL), { encoding: 'utf8' });

        // Run the script.
        const powershell = task.tool(task.which('pwsh') || task.which('powershell') || task.which('pwsh', true))
            .arg('-NoLogo')
            .arg('-NoProfile')
            .arg('-NonInteractive')
            .arg('-Command')
            .arg(`. '${filePath.replace(/'/g, "''")}'`);
        const options = <runner.IExecOptions>{
            failOnStdErr: false,
            errStream: process.stdout,
            outStream: process.stdout,
            ignoreReturnCode: true
        };

        // Run PowerShell
        const exitCode: number = await powershell.exec(options);

        // Fail on exit code.
        if (exitCode !== 0) {
            task.setResult(task.TaskResult.Failed, task.loc('JS_ExitCode', exitCode));
        }
    }
    catch (err) {
        task.setResult(task.TaskResult.Failed, err.message || 'run() failed');
    }
}

run();
