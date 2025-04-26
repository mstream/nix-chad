{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=fc843893cecc1838a59713ee3e50e9e7edc6207c";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=ff81ac966bb2cae68946d5ed5fc4994f96d0ffec";
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
      url = "github:cachix/git-hooks.nix?rev=dcf5072734cb576d2b0c59b2ac44f5050b5eac82";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=c61bfe3ae692f42ce688b5865fac9e0de58e1387";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=86484f6076aac9141df2bfcddbf7dcfce5e0c6bb";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=75898093fd957ea3d1b453fe1660d62587b3ca5d";
    };
    nixvim = {
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "nix-darwin";
        nixpkgs.follows = "nixpkgs";
        nuschtos-search.follows = "nuschtos-search";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nixvim?rev=d35dc6dfcae3ff1a0c72f2d59491a7d83e5505a3";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=c6f3ba2de525cf64a8acfe28002e7d1fb457f09b";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=066afe8643274470f4a294442aadd988356a478f";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=8d404a69efe76146368885110f29a2ca3700bee6";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
