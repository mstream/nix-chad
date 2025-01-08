_: {
  nix.gc = {
    automatic = true;
    interval = {
      Minute = 30;
    };
    options = "--delete-older-than 28d";
  };
}
