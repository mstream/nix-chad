#!/usr/bin/env bash

set -e
set -E
set -x

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

nix build .#docs
cp -r result/* docs/
chmod -R +w docs/*
