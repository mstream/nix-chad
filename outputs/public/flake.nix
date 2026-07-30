{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=c3e90c89649b07d1a96e4b9dd6cd0d6e44b91a74";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=5edf11c44bc78a0d334f6334cdaf7d60d732daab";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=17c9d6cdfc60c64f4ee8d306f9bc0b4ccb51481e";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=43b3c1ab9d40fb1dbb008f451988a91e375825e9";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=d4fd24667c8cbef124bb70a20380cab75ec8474d";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=50e6070082e0b4fbaf67dd8f346892a1a9ed685c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=21ea275a7c46aef9d4d6ddc962e6d562e9d94183";
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=667c8471f4a0fb24d702d1a61af8609f1a5f1ba6";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:nix-community/NUR?rev=6ee22a245ffa87cdb1b0f42bea2dacdc2365d4f6";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=36d55b5d41b1f0abd71ecdcee91553480689c376";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay?rev=1cf88ab9d83596db0e0c0d304a16809c410e2917";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=d1187f8bc71fb8aab02395869ec3f5c1920f75c0";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
