{ osConfig, pkgs, ... }:
let
  cfg = osConfig.chad;
  username = cfg.user.name;
  defaultProfile = import ./makeDefaultProfile.nix {
    inherit pkgs username;
    inherit (cfg) fontSize;
    inherit (cfg.browser) bookmarks extraExtensions;
  };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    policies = {
      # FIXME
      # policies do not seem to work, at least not with non-standard
      # firefox-devedition package
      AllowFileSelectionDialogs = true;
      AppAutoUpdate = false;
    };
    profiles = {
      "${username}" = defaultProfile;
    };
  };
}
