{
  description = "Development partition inputs.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=17c9d6cdfc60c64f4ee8d306f9bc0b4ccb51481e";
    };
    just-flake.url = "github:juspay/just-flake?rev=0e33952a4bcd16cd54ee3aba8111606c237d4526";
    lint-nix.url = "github:xc-jp/lint.nix?rev=a3e8324baec349dd65c3bd8f84a56ab295ff507f";
    nix-unit = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nix-unit?rev=3a484e17e4911ed97d56e37506f22e294c7c0ccd";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=21ea275a7c46aef9d4d6ddc962e6d562e9d94183";
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:nix-community/NUR?rev=6ee22a245ffa87cdb1b0f42bea2dacdc2365d4f6";
    };
    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay?rev=1cf88ab9d83596db0e0c0d304a16809c410e2917";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=d1187f8bc71fb8aab02395869ec3f5c1920f75c0";
    };
  };

  outputs = _: { };
}
