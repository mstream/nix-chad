{ easy-ps, pkgs, version, ... }:
config:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${config.username}" = import ./user-config.nix
    {
      inherit easy-ps pkgs version;
    }
    config;
}
