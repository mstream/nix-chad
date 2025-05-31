{
  description = "Development partition inputs.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=c621e8422220273271f52058f618c94e405bb0f5";
    };
    just-flake.url = "github:juspay/just-flake?rev=0e33952a4bcd16cd54ee3aba8111606c237d4526";
    lint-nix.url = "github:xc-jp/lint.nix?rev=a3e8324baec349dd65c3bd8f84a56ab295ff507f";
    nix-unit = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nix-unit?rev=be0d299e89a31e246c5472bf0e1005d4cc1e9e55";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=4f992ca40503578342726bebca5ebda5b0a01387";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=a384c7ffe001a45980b48c741eeef64bf237475c";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=e07eb426b07efc1859d6a7de51e77250d2d7e57f";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=1f3f7b784643d488ba4bf315638b2b0a4c5fb007";
    };
  };

  outputs = _: { };
}
