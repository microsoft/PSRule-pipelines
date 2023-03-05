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
        let input_path: string = task.getPathInput('path', /*required*/ false, /*check*/ true);
        let input_inputType: string = task.getInput('inputType', /*required*/ false);
        let input_inputPath: string = task.getInput('inputPath', /*required*/ false);
        let input_source: string = task.getPathInput('source', /*required*/ false, /*check*/ false);
        let input_modules: string = task.getInput('modules', /*required*/ false);
        let input_baseline: string = task.getInput('baseline', /*required*/ false);
        let input_conventions: string = task.getInput('conventions', /*required*/ false);
        let input_option: string = task.getInput('option', /*required*/ false);
        let input_outcome: string = task.getInput('outcome', /*required*/ false);
        let input_outputFormat: string = task.getPathInput('outputFormat', /*required*/ false, /*check*/ false) || 'None';
        let input_outputPath: string = task.getPathInput('outputPath', /*required*/ false, /*check*/ false);
        let input_prerelease: boolean = task.getBoolInput('prerelease', /*required*/ false);
        let input_repository: string = task.getInput('repository', /*required*/ false);
        let input_summary: boolean = task.getBoolInput('summary', /*required*/ false);
        let input_version: string = task.getInput('version', /*required*/ false);

        // Write bootstrap commands to a temporary script file
        let contents: string[] = [];

        // Import SDK
        contents.push(`$rootPath = '${__dirname}';`);
        contents.push(`$sdkPath = Join-Path -Path $rootPath -ChildPath 'ps_modules/VstsTaskSdk';`);
        contents.push(`Import-Module $sdkPath -ArgumentList @{ NonInteractive = 'true' } -ErrorAction Stop`);

        // Prepare parameters
        contents.push(`$scriptParams = @{ Path = '${input_path}'; InputType = '${input_inputType}'; InputPath = '${input_inputPath}' };`);
        if (input_source !== undefined) {
            contents.push(`$scriptParams['Source'] = '${input_source}'`);
        }
        if (input_modules !== undefined) {
            contents.push(`$scriptParams['Modules'] = '${input_modules}'`);
        }
        if (input_baseline !== undefined) {
            contents.push(`$scriptParams['Baseline'] = '${input_baseline}'`);
        }
        if (input_conventions !== undefined) {
            contents.push(`$scriptParams['Conventions'] = '${input_conventions}'`);
        }
        if (input_option !== undefined) {
            contents.push(`$scriptParams['Option'] = '${input_option}'`);
        }
        if (input_outcome !== undefined) {
            contents.push(`$scriptParams['Outcome'] = '${input_outcome}'`);
        }
        if (input_outputFormat !== undefined) {
            contents.push(`$scriptParams['OutputFormat'] = '${input_outputFormat}'`);
        }
        if (input_outputPath !== undefined) {
            contents.push(`$scriptParams['OutputPath'] = '${input_outputPath}'`);
        }
        if (input_prerelease !== undefined && input_prerelease) {
            contents.push(`$scriptParams['PreRelease'] = $True;`);
        }
        else {
            contents.push(`$scriptParams['PreRelease'] = $False;`);
        }
        if (input_repository !== undefined) {
            contents.push(`$scriptParams['Repository'] = '${input_repository}'`);
        }
        if (input_summary !== undefined && input_summary) {
            contents.push(`$scriptParams['Summary'] = $True;`);
        }
        else {
            contents.push(`$scriptParams['Summary'] = $False;`);
        }
        if (input_version !== undefined) {
            contents.push(`$scriptParams['Version'] = '${input_version}'`);
        }

        // Add PowerShell entry point
        contents.push(` . $rootPath\\powershell.ps1 @scriptParams`.trim());

        // Write the script to disk.
        task.assertAgent('2.144.0');
        const tempDirectory = task.getVariable('agent.tempDirectory');
        task.checkPath(tempDirectory, `${tempDirectory} (agent.tempDirectory)`);
        const filePath = path.join(tempDirectory, 'run_ps_rule_assert.ps1');
        fs.writeFileSync(filePath, '\ufeff' + contents.join(os.EOL), { encoding: 'utf8' });

        // Run the script.
        const powershell = task.tool(task.which('pwsh') || task.which('powershell') || task.which('pwsh', true))
            .arg('-NoLogo')
            .arg('-NoProfile')
            .arg('-NonInteractive')
            .arg('-Command')
            .arg(`. '${filePath.replace(/'/g, "''")}'`);
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
