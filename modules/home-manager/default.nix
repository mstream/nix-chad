{ config, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${config.chad.user.name}" = import ./user-config.nix;
  };
}
