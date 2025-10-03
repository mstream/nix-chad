{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=000eadb231812ad6ea6aebd7526974aaf4e79355";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=9100a0f413b0c601e0533d1d94ffd501ce2e7885";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=758cf7296bee11f1706a574c77d072b8a7baa881";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=cfc9f7bb163ad8542029d303e599c0f7eee09835";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=3b955f5f0a942f9f60cdc9cacb7844335d0f21c3";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=ebb7162a975074fb570a2c3ac02bc543ff2e9df4";
      # TODO: remove when logind.settings is backported to the darwin branch of nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=b2f842e4d99dc35a0951b9582c64bb26789e929d";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=e5086dd493a96bf57f512c48b7850f2b5783ded1";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=a30decbd5fc231e84dfefeb75bc7f57d8167726c";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=a5dd0f24eb9be5eaeb478ab90ec14caf5619d276";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=7d4c0fc4ffe3bd64e5630417162e9e04e64b27a4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=5eda4ee8121f97b218f7cc73f5172098d458f1d1";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
