{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=$NIX_DARWIN";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=$FLAKE_COMPAT";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=$FLAKE_PARTS";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=$FLAKE_UTILS";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=$GIT_HOOKS";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=$HOME_MANAGER";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=$NIX_ROSETTA_BUILDER";
      # TODO: remove when logind.settings is backported to the darwin branch of nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=$NIXPKGS";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=$NIXPKGS_FIREFOX_DARWIN";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=$NIXVIM";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=$NUR";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=$NUSCHTOS_SEARCH";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=$TREEFMT_NIX";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=$YANTS";
    };
  };

  outputs = _: { };
}
