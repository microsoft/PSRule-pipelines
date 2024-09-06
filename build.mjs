// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// Build script for extension

import * as esbuild from 'esbuild'
import {taskExtrasPlugin} from './plugins/extras.js'

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-assertV2/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-assert/ps-rule-assertV2/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: true,
  target: 'node10',
  external: ['shelljs'],
  plugins: [taskExtrasPlugin],
  sourceRoot: './tasks/ps-rule-assertV2',
  outbase: 'out/dist/ps-rule-assert/ps-rule-assertV2',
})

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-installV2/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-install/ps-rule-installV2/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: true,
  target: 'node10',
  external: ['shelljs'],
  plugins: [taskExtrasPlugin],
  sourceRoot: './tasks/ps-rule-installV2',
  outbase: 'out/dist/ps-rule-install/ps-rule-installV2',
})
