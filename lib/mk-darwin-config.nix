{ darwin, home-manager, nur, ... }:
system: chadConfig:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    { chad = chadConfig; }
    home-manager.darwinModules.home-manager
    ../modules/default.nix
    (import ../modules/home-manager/default.nix chadConfig)
    ({ pkgs, ... }: (import ../modules/nix.nix { inherit pkgs system; }))
    (import ../modules/nixpkgs.nix { inherit nur; })
  ];
}
