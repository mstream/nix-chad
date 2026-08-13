{
  config,
  nur,
  purescript-overlay,
  ...
}:
let
  cfg = config.chad;
in
{
  nixpkgs = {
    config = {
      allowBroken = false;
      allowUnfree = !cfg.software.openSourceOnly;
    };
    overlays = import ../../overlays/nixpkgs.nix {
      inherit nur purescript-overlay;
    };
  };
}
