{ chadLib, pkgs, ... }:
{
  buildKeymapsDocs = import ./build-keymaps-docs.nix {
    inherit chadLib pkgs;
  };
  buildOptionsDocs = import ./build-options-docs.nix {
    inherit chadLib pkgs;
  };
}
