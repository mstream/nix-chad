{
  config,
  pkgs,
  system,
  ...
}:
let
  cfg = config.chad;
in
{
  imports = [
    ./gc.nix
    ./optimise.nix
  ];
  config = {
    nix = {
      configureBuildUsers = true;
      extraOptions = ''
        system = ${system}
        extra-platforms = ${system}
        experimental-features = nix-command flakes
        build-users-group = nixbld
        download-buffer-size = 134217728
      '';
      package = pkgs.nix;
      registry = {
        nixpkgs = {
          from = {
            id = "nixpkgs";
            type = "indirect";
          };
          to = {
            owner = "NixOS";
            ref = "release-${cfg.nixpkgsReleaseVersion}";
            repo = "nixpkgs";
            type = "github";
          };
        };
      };
      settings = {
        auto-optimise-store = false;
        sandbox = false;
        ssl-cert-file = cfg.sslCertFilePath;
        substituters = [
          "https://cache.garnix.io/"
          "https://cache.iog.io/"
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://rossabaker.cachix.org"
          "https://typelevel.cachix.org/"
        ];
        trusted-public-keys = [
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "rossabaker.cachix.org-1:KK/CQTeAGEurCUBy3nDl9PdR+xX+xtWQ0C/GpNN6kuw="
          "typelevel.cachix.org-1:UnD9fMAIpeWfeil1V/xWUZa2g758ZHk8DvGCd/keAkg="
        ];
        trusted-substituters = [
          "https://cache.garnix.io/"
          "https://cache.iog.io/"
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://rossabaker.cachix.org/"
          "https://typelevel.cachix.org/"
        ];
      };
    };
  };
}
