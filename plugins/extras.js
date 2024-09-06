// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import * as fs from 'fs';
import * as path from 'path';

let options = {}

// Copy files that end with .ps1 or .json
function filter(src, dest) {
  return src.endsWith('.ps1') || src.endsWith('.json')
}

export const taskExtrasPlugin = {
  name: 'task-extras',
  setup(build) {
    const options = build.initialOptions

    build.onEnd((result) => {
      // Find all files that end with .ps1 or .json
      const files = fs.readdirSync(options.sourceRoot).filter(filter);

      // Copy each file to the output directory
      files.forEach((file) => {
        const src = path.join(options.sourceRoot, file);
        const dest = path.join(options.outbase, file);

        // Ensure the destination directory exists
        const destinationDir = path.dirname(dest);
        if (!fs.existsSync(destinationDir)) {
          fs.mkdirSync(destinationDir, { recursive: true });
        }

        // Copy the file
        fs.cpSync(src, dest, {
          dereference: options.dereference || true,
          errorOnExist: options.errorOnExist || false,
          force: options.force || true,
          preserveTimestamps: options.preserveTimestamps || true,
          recursive: options.recursive || true,
        });
      });
    });
  },
}
