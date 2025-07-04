{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=536f951efb1ccda9b968e3c9dee39fbeb6d3fdeb";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=9100a0f413b0c601e0533d1d94ffd501ce2e7885";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=77826244401ea9de6e3bac47c2db46005e1f30b5";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=16ec914f6fb6f599ce988427d9d94efddf25fe6d";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=501cfec8277f931a9c9af9f23d3105c537faeafe";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=2c9abb11f4780e7954cd76c7d85441003da21fc8";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=a0c3e9b0afc0e57e1d25b2e4043af7c1e89f720b";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=13cc4d84572c5f5d469a3a3454fa2028f78a3137";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=b168606d61957969297f7791f3aa7f95ab83ba0b";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=8dfe5879dd009ff4742b668d9c699bc4b9761742";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=ac8e6f32e11e9c7f153823abc3ab007f2a65d3e1";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
