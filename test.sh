#!/usr/bin/env bash

set -e
set -x

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

nix build --show-trace "${SCRIPT_DIR}#lints.all-checks"

NIXPKGS_ALLOW_UNFREE=1 nix eval --impure --show-trace "${SCRIPT_DIR}/test/#tests"

INSTALLABLE=darwinConfigurations.macbook.aarch64-darwin.system

cd "${SCRIPT_DIR}/examples/custom"
nix flake update
nix build --show-trace "./#${INSTALLABLE}"

cd "${SCRIPT_DIR}/examples/minimal"
nix flake update
nix build --show-trace "./#${INSTALLABLE}"
