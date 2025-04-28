_: {
  services.nix-daemon = {
    enable = true;
    enableSocketListener = false;
    tempDir = null;
  };
}
