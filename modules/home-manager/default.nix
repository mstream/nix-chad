{ defaultGpgKey, easy-ps, fontSize, pkgs, username, version, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${username}" = (import ./user-config.nix {
    inherit defaultGpgKey easy-ps fontSize pkgs username version;
  });
}
