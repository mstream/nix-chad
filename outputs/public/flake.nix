{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=688427b1aab9afb478ca07989dc754fa543e03d5";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=65f23138d8d09a92e30f1e5c87611b23ef451bf3";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=2cccadc7357c0ba201788ae99c4dfa90728ef5e0";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=46600f39dd738b2e7fa9da358d21684e2d493845";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=44777152652bc9eacf8876976fa72cc77ca8b9d8";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=ebb7162a975074fb570a2c3ac02bc543ff2e9df4";
      # TODO: remove when logind.settings is backported to the darwin branch of nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=62cac6c5d5b70601ff3da3e6573cb2d461f86953";
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=a9d0e063bcbb43f18f5baf42713ba240f3a8ab22";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=72bffdb9666817f9bae30ebfbf858a83de20776b";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=e29de6db0cb3182e9aee75a3b1fd1919d995d85b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=5b4ee75aeefd1e2d5a1cc43cf6ba65eba75e83e4";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
