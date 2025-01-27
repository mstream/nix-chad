{ chadLib, pkgs, ... }:
{
  buildKeymapsDocs = pkgs.callPackage ./build-keymaps-docs.nix {
    inherit chadLib;
  };
  buildOptionsDocs = pkgs.callPackage ./build-options-docs.nix {
    inherit chadLib;
  };
}
