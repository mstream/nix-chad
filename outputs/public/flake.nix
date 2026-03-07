{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=ebec37af18215214173c98cf6356d0aca24a2585";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=5edf11c44bc78a0d334f6334cdaf7d60d732daab";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=f20dc5d9b8027381c474144ecabc9034d6a839a3";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=39f53203a8458c330f61cc0759fe243f0ac0d198";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=080657a04188aca25f8a6c70a0fb2ea7e37f1865";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=50e6070082e0b4fbaf67dd8f346892a1a9ed685c";
      # TODO: remove when logind.settings is backported to the darwin branch of nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=fabb8c9deee281e50b1065002c9828f2cf7b2239";
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=b8f76bf5751835647538ef8784e4e6ee8deb8f95";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=73ddcced42469569c9ed9b151ca9d2c0f72612f2";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=b6f77b88e9009bfde28e2130e218e5123dc66796";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=3710e0e1218041bbad640352a0440114b1e10428";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
