config: {
  services = {
    nix-daemon = import ./nix-daemon;
    yabai = import ./yabai config;
  };
}
