{
  description = "Development partition inputs.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=2cccadc7357c0ba201788ae99c4dfa90728ef5e0";
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
    nixpkgs.url = "github:nixos/nixpkgs?rev=62cac6c5d5b70601ff3da3e6573cb2d461f86953";
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=72bffdb9666817f9bae30ebfbf858a83de20776b";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=5b4ee75aeefd1e2d5a1cc43cf6ba65eba75e83e4";
    };
  };

  outputs = _: { };
}
