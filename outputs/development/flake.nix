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
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nix-unit?rev=21a5496ae32b16b73601ef835b9f6497b19024dc";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=fd1462031fdee08f65fd0b4c6b64e22239a77870";
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=164cb0317169a70f0a93c8cc605c3309d35fec9b";
    };
    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay?rev=1cf88ab9d83596db0e0c0d304a16809c410e2917";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=df3c0640565d04a0261253cdd89fce78ec50168a";
    };
  };

  outputs = _: { };
}
