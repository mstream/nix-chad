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

  chadLibBundle = import ../lib { inherit nixpkgs yants; };
  chadLib = chadLibBundle.implementation;

  partitions = import ./partitions.nix { inherit chadLib; };

  args = {
    inherit inputs;
    specialArgs = { inherit chadLib chadLibBundle; };
  };

  module = import ./mk-module.nix {
    inherit
      chadLib
      ciSystems
      flake-parts
      partitions
      ;

    debug = true;
  };
in
flake-parts.lib.mkFlake args module
