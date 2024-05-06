{ config, ... }:
let cfg = config.chad;
in {
  system = {
    defaults = {
      dock = {
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
        tilesize = cfg.fontSize;
      };
      finder = {
        _FXShowPosixPathInTitle = false;
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = true;
      };
      loginwindow = {
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
      NSGlobalDomain = {
        _HIHideMenuBar = false;
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
      spaces.spans-displays = false;
    };
    keyboard = {
      enableKeyMapping = false;
      # Surprisingly, this public option is ignored as it can't be set by a user (based on the implementation)...
      # it sounds like something that may be corrected in further versions.
      # Temporarily, I am replacing it with a custom script in ZSH. 
      #remapCapsLockToEscape = remapCapsLock;
      #userKeyMapping = if remapLeftArrow then [{
      #  HIDKeyboardModifierMappingSrc = 30064771152;
      #  HIDKeyboardModifierMappingDst = 30064771300;
      #}] else
      #  [ ];
    };
    stateVersion = 4;
  };
}
