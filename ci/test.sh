#!/usr/bin/env bash

set -e
set -E
set -x

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

if ! nix flake check --all-systems --show-trace; then
    echo "nix flake does not evaluate properly" >&2
    exit 1
fi

if ! NIXPKGS_ALLOW_UNFREE=1 nix eval --impure --show-trace "test/#tests"; then
    echo "unit tests are failing" >&2
    exit 1
fi

if ! nix build --print-build-logs --show-trace ".#lints.all-checks"; then
    echo "coding style is not up to standards" >&2
    exit 1
fi

# CI runs on Linux machines as MacOS ones are 10 times as expensive.
# Therefore, this suite of test will be executed only from a
# development machine (running MacOS).
if [[ "${CI}" != "true" ]]; then

    INSTALLABLE=darwinConfigurations.macbook.aarch64-darwin.system

    cd "${REPO_ROOT}/examples/minimal"
    nix flake update
    if ! nix build --show-trace "./#${INSTALLABLE}"; then
        echo "minimal example is broken" >&2
        exit 1
    fi

    cd "${REPO_ROOT}/examples/custom"
    nix flake update
    if ! nix build --show-trace "./#${INSTALLABLE}"; then
        echo "custom example is broken" >&2
        exit 1
    fi

    cd "$(mktemp -d)"
    nix flake init --template "${REPO_ROOT}"
    sed "s%github:mstream/nix-chad/main%git+file:${REPO_ROOT}?shallow=1%g" flake.nix >tmp.nix && mv tmp.nix flake.nix
    nix flake update
    if ! nix build --show-trace "./#${INSTALLABLE}"; then
        echo "template is broken" >&2
        exit 1
    fi
fi

if [[ $(git diff --stat) != '' ]]; then
  echo 'git branch is dirty'
  echo 'vvv'
  git status
  git diff HEAD
  echo '^^^'
  exit 1
else
  echo 'git branch is clean'
fi


