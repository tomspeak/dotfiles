#!/bin/bash
set -euo pipefail

package_dir="$(cd "$(dirname "$0")" && pwd)"
xargs npm install -g <"$package_dir/global-packages.txt"
