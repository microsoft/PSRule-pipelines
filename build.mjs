// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// Build script for extension

import * as esbuild from 'esbuild'

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-assertV0/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-assert/ps-rule-assertV0/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: true,
  target: 'node6',
  external: ['shelljs'],
})

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-installV0/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-install/ps-rule-installV0/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: true,
  target: 'node6',
  external: ['shelljs'],

})

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-assertV1/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-assert/ps-rule-assertV1/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: true,
  target: 'node10',
  external: ['shelljs'],
})

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-installV1/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-install/ps-rule-installV1/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: false,
  target: 'node10',
  external: ['shelljs'],
})

await esbuild.build({
  entryPoints: ['./tasks/ps-rule-assertV2/powershell.ts'],
  bundle: true,
  outfile: 'out/dist/ps-rule-assert/ps-rule-assertV2/powershell.js',
  platform: 'node',
  format: 'cjs',
  minify: true,
  target: 'node10',
  external: ['shelljs'],
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
})
