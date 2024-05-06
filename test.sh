#!/usr/bin/env bash

set -e
set -x

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if ! NIXPKGS_ALLOW_UNFREE=1 nix eval --impure --show-trace "${SCRIPT_DIR}/test/#tests"; then
    echo "unit tests are failing" >&2
    exit 1
fi

INSTALLABLE=darwinConfigurations.macbook.aarch64-darwin.system

cd "${SCRIPT_DIR}/examples/minimal"
nix flake update
if ! nix build --show-trace "./#${INSTALLABLE}"; then
    echo "minimal example is broken" >&2
    exit 1
fi

cd "${SCRIPT_DIR}/examples/custom"
nix flake update
if ! nix build --show-trace "./#${INSTALLABLE}"; then
    echo "custom example is broken" >&2
    exit 1
fi

cd "$(mktemp -d)"
nix flake init --template "${SCRIPT_DIR}"
sed "s%github:mstream/nix-chad/main%git+file:${SCRIPT_DIR}?shallow=1%g" flake.nix >tmp.nix && mv tmp.nix flake.nix
nix flake update
if ! nix build --show-trace "./#${INSTALLABLE}"; then
    echo "template is broken" >&2
    exit 1
fi

if ! nix build --show-trace "${SCRIPT_DIR}#lints.all-checks"; then
    echo "coding style is not up to standards" >&2
    exit 1
fi
