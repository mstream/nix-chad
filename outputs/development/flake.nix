{
  description = "Development partition inputs.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=57928607ea566b5db3ad13af0e57e921e6b12381";
    };
    just-flake.url = "github:juspay/just-flake?rev=0e33952a4bcd16cd54ee3aba8111606c237d4526";
    lint-nix.url = "github:xc-jp/lint.nix?rev=a3e8324baec349dd65c3bd8f84a56ab295ff507f";
    nix-unit = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nix-unit?rev=1c9ab50554eed0b768f9e5b6f646d63c9673f0f7";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=e764fc9a405871f1f6ca3d1394fb422e0a0c3951";
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=197e0b37cd38b86556175fa8818f3f57f47632b8";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=337a4fe074be1042a35086f15481d763b8ddc0e7";
    };
  };

  outputs = _: { };
}
