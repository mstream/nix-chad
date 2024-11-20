{
  config,
  nixpkgs-firefox-darwin,
  nur,
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
    overlays = import ../overlays/nixpkgs.nix { inherit nixpkgs-firefox-darwin nur; };
  };
}
