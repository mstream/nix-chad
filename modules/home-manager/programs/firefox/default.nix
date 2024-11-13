{ osConfig, pkgs, ... }:
let
  cfg = osConfig.chad;
  username = cfg.user.name;
  exts = pkgs.nur.repos.rycee.firefox-addons;
  defaultExtensions = with exts; [
    adaptive-tab-bar-colour
    adblocker-ultimate
    buster-captcha-solver
    gruvbox-dark-theme
    surfingkeys
  ];
  customExtensions =
    if cfg.browser.extraExtensions == null then [ ] else cfg.browser.extraExtensions exts;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    policies = {
      # policies do not seem to work, at least not with non-standard
      # firefox-devedition-pin package
      AllowFileSelectionDialogs = true;
      AppAutoUpdate = false;
    };
    profiles = {
      "${username}" = {
        inherit (cfg.browser) bookmarks;
        extensions = defaultExtensions ++ customExtensions;
        id = 0;
        isDefault = true;
        name = username;
        settings = {
          "app.normandy.enabled" = false;
          "app.update.auto" = false;
          "app.update.download.promptMaxAttempts" = 0;
          "app.update.elevation.promptMaxAttempts" = 0;
          "app.update.staging.enabled" = false;
          "browser.display.auto_quality_min_font_size" = cfg.fontSize;
          "browser.bookmarks.addedImportButton" = false;
          "browser.newtabpage.enabled" = false;
          "browser.startup.homepage" = "https://google.com";
          "browser.toolbars.bookmarks.visibility" = "newtab";
          "extensions.autoDisableScopes" = 0;
          "extensions.pocket.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
          "services.sync.declinedEngines" = "addons,passwords,prefs";
          "services.sync.engine.addons" = false;
          "services.sync.engineStatusChanged.addons" = true;
          "services.sync.engine.passwords" = false;
          "services.sync.engine.prefs" = false;
          "services.sync.engineStatusChanged.prefs" = true;
          "signon.rememberSignons" = true;
        };
      };
    };
  };
}
