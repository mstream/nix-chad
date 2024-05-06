chadConfig: _: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${chadConfig.user.name}" = import ./user-config.nix;
}
