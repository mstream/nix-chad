{
  description = "Development partition inputs.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=$FLAKE_PARTS";
    };
    just-flake.url = "github:juspay/just-flake?rev=$JUST_FLAKE";
    lint-nix.url = "github:xc-jp/lint.nix?rev=$LINT_NIX";
    nix-unit = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nix-unit?rev=$NIX_UNIT";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=$NIXPKGS";
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=$NUR";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=$TREEFMT_NIX";
    };
  };

  outputs = _: { };
}
