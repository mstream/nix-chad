{ osConfig, pkgs, ... }:
let
  cfg = osConfig.chad;

  bookmarks = builtins.map (b: {
    inherit (b) url;
    keyword = null;
    name = b.title;
    tags = [ ];
  }) cfg.browser.bookmarks;

  username = cfg.user.name;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    profiles = {
      "${username}" = {
        inherit bookmarks;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          browserpass
          vimium
        ];
        id = 0;
        isDefault = true;
        name = username;
        settings = {
          "app.update.auto" = false;
          "app.update.download.promptMaxAttempts" = 0;
          "app.update.elevation.promptMaxAttempts" = 0;
          "browser.display.auto_quality_min_font_size" = cfg.fontSize;
          "browser.newtabpage.enabled" = false;
          "browser.startup.homepage" = "https://google.com";
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
          "services.sync.declinedEngines" = "addons,passwords,prefs";
          "services.sync.engine.addons" = false;
          "services.sync.engineStatusChanged.addons" = true;
          "services.sync.engine.passwords" = false;
          "services.sync.engine.prefs" = false;
          "services.sync.engineStatusChanged.prefs" = true;
          "signon.rememberSignons" = false;
        };
      };
    };
  };
}
