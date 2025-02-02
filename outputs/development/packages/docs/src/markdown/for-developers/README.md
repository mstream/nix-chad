# For Developers

## Flake inputs

### Choosing version

Since this project uses flake-parts partitions module, flake inputs
are stored separately per each partition. This introduces possibility
of using different versions of inputs when evaluating different 
flake output attributes. This is possible even when inputs share a 
reference to the same branch. This is because commit revision is being
resolved and stored in the repo at the time of running `nix flake lock`
command, and this may happen at different times. In order to guarantee
that they share the same versions, use these rules: 

1. If the input repository uses tags - use them.
1. If the input repository does not use tags - use commit hashes.
1. For `nixpkgs` use commit hashes from the branch which is appropriate for this project, namely `nixpkgs-{NIXOS_RELEASE_VERSION}-darwin`.
1. For `home-manager` use commit hashes from the branch which corresponds to the `nixpkgs` version, namely `release-${NIXOS_RELEASE_VERSION}`.
1. For `nix-darwin` use commit hashes from the branch which corresponds to the `nixpkgs` version, namely `nix-darwin-${NIXOS_RELEASE_VERSION}`.
1. For `nixvim` use commit hashes from the branch which corresponds to the `nixpkgs` version, namely `nixos-${NIXOS_RELEASE_VERSION}`.

### Control version of transitive dependencies

For each input of a flake type, identify its dependencies, define them
as this project's inputs and make them being used by the input with the
help of `inputs.{NAME_OF_TRANSITIVE_INPUT}.follows` property.



