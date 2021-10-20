#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

set -e

SCRIPTS_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${SCRIPTS_DIRECTORY}/.."

echo '  Enumerating test files:'
files=$(find sapp -name '*_test.py' ! -name 'sharded_files_test.py' ! -name 'cli_test.py')
echo "${files}"
if [[ -z "${files}" ]]; then
  echo 'No test files found, exiting.'
  exit 2
fi

echo '  Running all tests:'
echo "${files}" | sed 's/.py$//' | sed 's:/:.:g' | xargs python -m coverage run -m unittest -v
python -m coverage report --show-missing --ignore-errors --skip-empty
