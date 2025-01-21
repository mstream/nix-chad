{
  nixpkgsLib,
  yants,
  ...
}:
let
  core = builtins;

  attrsets = import ./attrsets.nix {
    inherit core yants;
    nixpkgsLibAttrsets = nixpkgsLib.attrsets;
  };

  standardLib = attrsets.implementation.merge nixpkgsLib {
    inherit core;
  };

  externalLib = attrsets.implementation.merge standardLib {
    inherit yants;
  };

  mergedLib = attrsets.implementation.merge externalLib localLibImplementations;

  bash = import ./bash mergedLib;
  constants = import ./constants mergedLib;
  enum = import ./enum mergedLib;
  functions = import ./functions mergedLib;
  lua = import ./lua mergedLib;
  nixCli = import ./nix-cli mergedLib;
  shortcuts = import ./shortcuts mergedLib;

  localLibBundles = {
    inherit
      attrsets
      bash
      constants
      enum
      functions
      lua
      nixCli
      shortcuts
      ;
  };

  localLibImplementations = core.mapAttrs (
    functions.implementation.constant
    (bundle: bundle.implementation)
  ) localLibBundles;

  localLibTests = core.mapAttrs (functions.implementation.constant (
    bundle: bundle.tests
  )) localLibBundles;
in
{
  tests = localLibTests;
  implementation = mergedLib;
}
