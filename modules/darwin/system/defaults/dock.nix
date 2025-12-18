{ config, ... }:
let
  cfg = config.chad;
in
{
  config.system.defaults.dock = {
    appswitcher-all-displays = true;
    autohide = true;
    autohide-delay = 999.9;
    autohide-time-modifier = 0.5;
    dashboard-in-overlay = false;
    enable-spring-load-actions-on-all-items = false;
    expose-animation-duration = 1.0;
    expose-group-apps = true;
    largesize = 16;
    launchanim = true;
    magnification = false;
    mineffect = "genie";
    minimize-to-application = true;
    mouse-over-hilite-stack = true;
    mru-spaces = true;
    orientation = "bottom";
    persistent-apps = [ ];
    persistent-others = [ ];
    scroll-to-open = false;
    show-process-indicators = true;
    show-recents = false;
    showAppExposeGestureEnabled = false;
    showDesktopGestureEnabled = false;
    showLaunchpadGestureEnabled = true;
    showMissionControlGestureEnabled = !cfg.manageWindows.enable;
    showhidden = true;
    slow-motion-allowed = false;
    static-only = false;
    tilesize = 2 * cfg.fontSize;
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };
}
