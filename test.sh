#!/usr/bin/env bash

nix eval .#tests
nix build --show-trace ./test#darwinConfigurations.macbook.aarch64-darwin.system
