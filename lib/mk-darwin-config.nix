{ darwin, home-manager, nur, ... }:
system: chadConfig:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    { chad = chadConfig; }
    home-manager.darwinModules.home-manager
    ../modules/default.nix
  ];
  specialArgs = { inherit nur system; };
}
