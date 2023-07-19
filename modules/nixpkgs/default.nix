{ nur, ... }: {
  nixpkgs = {
    config = {
      allowBroken = false;
      allowUnfree = false;
    };
    overlays = import ../../overlays/nixpkgs.nix { inherit nur; };
  };
}
