{ config, ... }:
let
  cfg = config.chad;
in
{
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
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      finder = {
        _FXShowPosixPathInTitle = false;
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = true;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      loginwindow = {
        SHOWFULLNAME = false;
        autoLoginUser = "Off";
        GuestEnabled = false;
        PowerOffDisabledWhileLoggedIn = false;
        ShutDownDisabled = false;
        ShutDownDisabledWhileLoggedIn = false;
        SleepDisabled = false;
        RestartDisabled = false;
        RestartDisabledWhileLoggedIn = false;
        DisableConsoleAccess = false;
      };
      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0;
        ShowDayOfMonth = true;
        ShowDayOfWeek = true;
        ShowSeconds = false;
      };
      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleFontSmoothing = 2;
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = false;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        AppleTemperatureUnit = "Celsius";
        "com.apple.mouse.tapBehavior" = null;
        "com.apple.springing.enabled" = true;
        "com.apple.springing.delay" = 0.5;
        "com.apple.swipescrolldirection" = cfg.mouse.naturalScrollDirection;
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.trackpad.scaling" = 1.0;
        "com.apple.trackpad.trackpadCornerClickBehavior" = null;
        InitialKeyRepeat = 0;
        KeyRepeat = 0;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSWindowResizeTime = 0.1;
      };
      screencapture = {
        type = "png";
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 5;
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
      spaces.spans-displays = false;
      trackpad = {
        ActuationStrength = 1;
        Clicking = false;
        Dragging = false;
        TrackpadThreeFingerDrag = false;
      };
      universalaccess = {
        /*
          closeViewScrollWheelToggle = false;
          closeViewZoomFollowsFocus = false;
          mouseDriverCursorSize = 1.0;
          reduceMotion = false;
          reduceTransparency = false;
        */
      };
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
