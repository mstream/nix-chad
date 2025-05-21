{
  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=$FLAKE_PARTS";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=$FLAKE_UTILS";
    nixpkgs.url = "github:nixos/nixpkgs?ref=$NIXPKGS";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=$YANTS";
    };
  };

  outputs = inputs: import ./outputs inputs "$NIXOS";
}
