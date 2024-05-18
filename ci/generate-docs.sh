#!/usr/bin/env bash

set -e
set -E
set -x

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

nix build .#docs
cp result/* docs/
