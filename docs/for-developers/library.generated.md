# Nix Chad Library {#sec-functions-library-darwin}
Darwin related functions

## `lib.darwin.makeSystem` {#function-library-lib.darwin.makeSystem}

Create activation scripts for Darwin system with a desired config applied.

### Inputs

`flakeInputs`

: flake inputs containing darwin, home-manager and nur

`system`

: host system

`chadConfig`

: nix-chad configuration


