{
  chadLib,
  config,
  pkgs,
  system,
  ...
}:
let
  cfg = config.chad;
  userName = "${cfg.user.name}";
  substitutersInfo = {
    "https://cache.nixos.org" =
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";

    "https://nix-community.cachix.org" =
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

    "https://cache.garnix.io" =
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
  };

  substituterPublicKeys = chadLib.core.attrValues substitutersInfo;

  substituterUrls = chadLib.lists.imap1 (
    idx: url: "${url}?priority=${chadLib.core.toString idx}"
  ) (chadLib.core.attrNames substitutersInfo);
in
{
  imports = [
    ./gc.nix
    ./optimise.nix
  ];
  config = {
    nix = {
      extraOptions = ''
        system = ${system}
        extra-platforms = ${system}
        experimental-features = nix-command flakes
        build-users-group = nixbld
        download-buffer-size = 134217728
        trusted-users = ${userName}
      '';
      # This is only needed to bootstrap nix-rosetta-builder
      # These two builders cannot co-exist
      # linux-builder.enable = true;
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
        fallback = true;
        sandbox = true;
        ssl-cert-file = cfg.sslCertFilePath;
        substituters = substituterUrls;
        trusted-public-keys = substituterPublicKeys;
        trusted-substituters = substituterUrls;
      };
    };
  };
}
