{ config, ... }:
{
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${config.chad.user.name}" = import ./user-config.nix;
  };
}
