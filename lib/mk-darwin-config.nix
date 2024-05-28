{ darwin, home-manager, nur, ... }:
system: chadConfig:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    { chad = chadConfig; }
    home-manager.darwinModules.home-manager
    ../modules/default.nix
    (import ../modules/home-manager/default.nix chadConfig)
    ({ config, pkgs, ... }: (import ../modules/nix/default.nix { inherit config pkgs system; }))
    (import ../modules/nixpkgs.nix { inherit nur; })
  ];
}
