{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=75b99daa12b1fffd646d6c3cf13b06f1fa5cef63";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=9100a0f413b0c601e0533d1d94ffd501ce2e7885";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=c621e8422220273271f52058f618c94e405bb0f5";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=80479b6ec16fefd9c1db3ea13aeb038c60530f46";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=282e1e029cb6ab4811114fc85110613d72771dea";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=4f992ca40503578342726bebca5ebda5b0a01387";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=a384c7ffe001a45980b48c741eeef64bf237475c";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=cfea16cdbe4f13b5d39dfe3df747092448252c9d";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=e07eb426b07efc1859d6a7de51e77250d2d7e57f";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=f8a1c221afb8b4c642ed11ac5ee6746b0fe1d32f";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=1f3f7b784643d488ba4bf315638b2b0a4c5fb007";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
