chadLib: {
  characters = import ./characters.nix;
  keys = import ./keys.nix chadLib;
  nvim = import ./nvim.nix chadLib;
}
