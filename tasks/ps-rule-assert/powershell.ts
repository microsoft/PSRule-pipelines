// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import fs = require('fs');
import path = require('path');
import os = require('os');
import task = require('azure-pipelines-task-lib/task');
import runner = require('azure-pipelines-task-lib/toolrunner');
var uuidV4 = require('uuid/v4');

async function run() {
    try {
        // Get task
        task.setResourcePath(path.join(__dirname, 'task.json'));

        // Get inputs
        let input_path: string = task.getPathInput('path', /*required*/ true, /*check*/ true);
        let input_inputType: string = task.getInput('inputType', /*required*/ true);
        let input_inputPath: string = task.getInput('inputPath', /*required*/ true);
        let input_source: string = task.getPathInput('source', /*required*/ false, /*check*/ false);
        let input_modules: string = task.getInput('modules', /*required*/ false);
        let input_outputFormat: string = task.getPathInput('outputFormat', /*required*/ false, /*check*/ false) || 'None';
        let input_outputPath: string = task.getPathInput('outputPath', /*required*/ false, /*check*/ false);

        // Write bootstrap commands to a temporary script file
        let contents: string[] = [];

        // Import SDK
        contents.push(`$rootPath = '${__dirname}';`);
        contents.push(`$sdkPath = Join-Path -Path $rootPath -ChildPath 'ps_modules/VstsTaskSdk';`);
        contents.push(`Import-Module $sdkPath -ArgumentList @{ NonInteractive = 'true' }`);

        // Prepare parameters
        contents.push(`$scriptParams = @{ Path = '${input_path}'; InputType = '${input_inputType}'; InputPath = '${input_inputPath}' };`);
        if (input_source !== undefined) {
            contents.push(`$scriptParams['Source'] = '${input_source}'`);
        }
        if (input_modules !== undefined) {
            contents.push(`$scriptParams['Modules'] = '${input_modules}'`);
        }
        if (input_outputFormat !== undefined) {
            contents.push(`$scriptParams['OutputFormat'] = '${input_outputFormat}'`);
        }
        if (input_outputPath !== undefined) {
            contents.push(`$scriptParams['OutputPath'] = '${input_outputPath}'`);
        }

        // Add PowerShell entry point
        contents.push(` . $rootPath\\powershell.ps1 @scriptParams`.trim());

        // Write the script to disk.
        task.assertAgent('2.115.0');
        const tempDirectory = task.getVariable('agent.tempDirectory');
        task.checkPath(tempDirectory, `${tempDirectory} (agent.tempDirectory)`);
        const filePath = path.join(tempDirectory, uuidV4() + '.ps1');
        fs.writeFileSync(filePath, '\ufeff' + contents.join(os.EOL), { encoding: 'utf8' });

        // Run the script.
        const powershell = task.tool(task.which('pwsh') || task.which('powershell') || task.which('pwsh', true))
            .arg('-NoLogo')
            .arg('-NoProfile')
            .arg('-NonInteractive')
            .arg('-Command')
            .arg(`. '${filePath.replace("'", "''")}'`);
        const options = <runner.IExecOptions>{
            cwd: input_path,
            failOnStdErr: false,
            errStream: process.stdout,
            outStream: process.stdout,
            ignoreReturnCode: true
        };

        // Run PowerShell
        const exitCode: number = await powershell.exec(options);
    }
    catch (err) {
        task.setResult(task.TaskResult.Failed, err.message || 'run() failed');
    }
}

run();
