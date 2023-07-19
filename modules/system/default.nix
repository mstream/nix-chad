{ fontSize, ... }:
{
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 1000.0;
    autohide-time-modifier = 1.0;
    dashboard-in-overlay = false;
    enable-spring-load-actions-on-all-items = false;
    expose-animation-duration = 1.0;
    expose-group-by-app = true;
    launchanim = true;
    mineffect = "genie";
    minimize-to-application = true;
    mouse-over-hilite-stack = true;
    mru-spaces = true;
    orientation = "bottom";
    show-process-indicators = true;
    showhidden = true;
    show-recents = false;
    static-only = false;
    tilesize = fontSize;
  };
  system.defaults.finder = {
    _FXShowPosixPathInTitle = false;
    AppleShowAllExtensions = true;
    CreateDesktop = false;
    QuitMenuItem = true;
    FXEnableExtensionChangeWarning = true;
  };
  system.defaults.loginwindow = {
    SHOWFULLNAME = false;
    autoLoginUser = null;
    GuestEnabled = false;
    PowerOffDisabledWhileLoggedIn = false;
    ShutDownDisabled = false;
    ShutDownDisabledWhileLoggedIn = false;
    SleepDisabled = false;
    RestartDisabled = false;
    RestartDisabledWhileLoggedIn = false;
    DisableConsoleAccess = false;
  };
  system.defaults.NSGlobalDomain = {
    _HIHideMenuBar = true;
    AppleFontSmoothing = 2;
    AppleInterfaceStyle = "Dark";
    ApplePressAndHoldEnabled = false;
    InitialKeyRepeat = 0;
    KeyRepeat = 0;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
  };
  system.defaults.spaces.spans-displays = false;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.stateVersion = 4;
}
