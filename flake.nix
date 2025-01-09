{
  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts/main";
    };
    flake-utils.url = "github:numtide/flake-utils/main";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants/main";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      flake-utils,
      nixpkgs,
      yants,
      ...
    }:
    let
      ciSystems = with flake-utils.lib.system; [
        aarch64-darwin
        x86_64-darwin
        x86_64-linux
      ];

      chadLibBundle = import ./lib {
        inherit yants;
        nixpkgsLib = nixpkgs.lib;
      };

      chadLib = chadLibBundle.implementation;

      partitions = import ./partitions { inherit chadLib; };

      partitionFlakeOutputs = import ./partition-flake-outputs.nix {
        inherit chadLib partitions;
      };
    in
    flake-parts.lib.mkFlake
      {
        inherit inputs;
        specialArgs = {
          inherit chadLib;
        };
      }
      (
        _:
        chadLib.attrsets.merge partitionFlakeOutputs {
          debug = true;
          imports = [
            flake-parts.flakeModules.partitions
            (_: { flake.tests.chadLib = chadLibBundle.tests; })
          ];
          systems = ciSystems;
        }
      );
}
