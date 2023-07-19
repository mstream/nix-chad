{ pkgs, system, ... }: {
  nix = {
    configureBuildUsers = true;
    extraOptions = ''
      system = ${system}
      extra-platforms = ${system}
      experimental-features = nix-command flakes
      build-users-group = nixbld
    '';
    package = pkgs.nix;
    settings = {
      substituters = [];
      trusted-public-keys = [];
    };
  };
}
