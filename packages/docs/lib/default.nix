{ lib, pkgs, ... }:
{
  buildKeymapsDocs = import ./build-keymaps-docs.nix {
    inherit lib pkgs;
  };
  buildOptionsDocs = import ./build-options-docs.nix {
    inherit lib pkgs;
  };
}
