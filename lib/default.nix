{
  nixpkgs,
  yants,
  ...
}:
let
  core = builtins;
  nixpkgsLib = nixpkgs.lib;

  attrsets = import ./attrsets {
    inherit core yants;
    nixpkgsLibAttrsets = nixpkgsLib.attrsets;
  };

  standardLib = attrsets.implementation.merge nixpkgsLib {
    inherit core;
  };

  externalLib = attrsets.implementation.merge standardLib {
    inherit yants;
  };

  mergedLib = attrsets.implementation.merge externalLib implementation;

  bash = import ./bash mergedLib;
  constants = import ./constants mergedLib;
  enum = import ./enum mergedLib;
  functions = import ./functions mergedLib;
  kdl = import ./kdl mergedLib;
  lists = import ./lists mergedLib;
  lua = import ./lua mergedLib;
  markdown = import ./markdown mergedLib;
  nixCli = import ./nix-cli mergedLib;
  shortcuts = import ./shortcuts mergedLib;
  strings = import ./strings mergedLib;

  localLibBundles = {
    inherit
      attrsets
      bash
      constants
      enum
      functions
      kdl
      lists
      lua
      markdown
      nixCli
      shortcuts
      strings
      ;
  };

  mapLocalLibBundles =
    f: core.mapAttrs (functions.implementation.constant f) localLibBundles;

  implementation = mapLocalLibBundles (bundle: bundle.implementation);
in
{
  implementation = mergedLib;
  descriptions = mapLocalLibBundles (bundle: bundle.description);
  tests = mapLocalLibBundles (bundle: bundle.tests);
}
