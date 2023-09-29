{ nur, ... }: {
  nixpkgs = {
    config = {
      allowBroken = false;
      allowUnfree = true;
    };
    overlays = import ../../overlays/nixpkgs.nix { inherit nur; };
  };
}
