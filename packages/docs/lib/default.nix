{ pkgs, ... }:
{
  buildKeymapsDocs = import ./build-keymaps-docs.nix { inherit pkgs; };
  buildOptionsDocs = import ./build-options-docs.nix { inherit pkgs; };
}
