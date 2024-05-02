{ darwin, home-manager, home-manager-version, nur, ... }:
system: config:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    home-manager.darwinModule
    ../modules/default.nix
    ({ pkgs, ... }:
      (import ../modules/home-manager {
        inherit pkgs;
        version = home-manager-version;
      } config))
    ({ pkgs, ... }: (import ../modules/nix { inherit pkgs system; }))
    (import ../modules/nixpkgs { inherit nur; })
    (import ../modules/programs)
    (import ../modules/services config)
    (import ../modules/system config)
    (import ../modules/users config)
  ];
}
