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
      substituters =
        [ "https://cache.garnix.io/" "https://cache.iog.io/" "https://cache.nixos.org/" "https://nix-community.cachix.org"  "https://rossabaker.cachix.org/" "https://typelevel.cachix.org/" ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "rossabaker.cachix.org-1:KK/CQTeAGEurCUBy3nDl9PdR+xX+xtWQ0C/GpNN6kuw="
        "typelevel.cachix.org-1:UnD9fMAIpeWfeil1V/xWUZa2g758ZHk8DvGCd/keAkg="
      ];
      trusted-substituters =
        [ "https://cache.garnix.io/" "https://cache.iog.io/" "https://cache.nixos.org/" "https://nix-community.cachix.org"  "https://rossabaker.cachix.org/" "https://typelevel.cachix.org/" ];
    };
  };
}
