{
  groups,
  ...
}:
{
  comment = "Run all checks and tests.";
  groups = with groups.members; [
    generation
  ];
  script = ''
    FLAKE_COMPAT=$({{call_recipe}} get-commit-id edolstra/flake-compat master)
    export FLAKE_COMPAT

    FLAKE_PARTS=$({{call_recipe}} get-commit-id hercules-ci/flake-parts main)
    export FLAKE_PARTS

    FLAKE_UTILS=$({{call_recipe}} get-commit-id numtide/flake-utils main)
    export FLAKE_UTILS

    GIT_HOOKS=$({{call_recipe}} get-commit-id cachix/git-hooks.nix master)
    export GIT_HOOKS

    HOME_MANAGER=$({{call_recipe}} get-commit-id nix-community/home-manager release-24.11)
    export HOME_MANAGER

    JUST_FLAKE=$({{call_recipe}} get-commit-id juspay/just-flake main)
    export JUST_FLAKE

    LINT_NIX=$({{call_recipe}} get-commit-id xc-jp/lint.nix master)
    export LINT_NIX

    NIX_DARWIN=$({{call_recipe}} get-commit-id nix-darwin/nix-darwin nix-darwin-24.11)
    export NIX_DARWIN

    NIX_UNIT=$({{call_recipe}} get-commit-id nix-community/nix-unit main)
    export NIX_UNIT

    NIXPKGS_FIREFOX_DARWIN=$({{call_recipe}} get-commit-id bandithedoge/nixpkgs-firefox-darwin main)
    export NIXPKGS_FIREFOX_DARWIN

    NIXPKGS=$({{call_recipe}} get-commit-id NixOS/nixpkgs nixpkgs-24.11-darwin)
    export NIXPKGS

    NIXVIM=$({{call_recipe}} get-commit-id nix-community/nixvim nixos-24.11)
    export NIXVIM

    NUR=$({{call_recipe}} get-commit-id nix-community/NUR main)
    export NUR

    NUSCHTOS_SEARCH=$({{call_recipe}} get-commit-id NuschtOS/search main)
    export NUSCHTOS_SEARCH

    TREEFMT_NIX=$({{call_recipe}} get-commit-id numtide/treefmt-nix main)
    export TREEFMT_NIX

    YANTS=$({{call_recipe}} get-commit-id divnix/yants main)
    export YANTS

    {{call_recipe}} update-flake-inputs-at /
    {{call_recipe}} update-flake-inputs-at /outputs/development/
    {{call_recipe}} update-flake-inputs-at /outputs/public/
  '';
}
