{ config, ... }:
let
  cfg = config.chad;
in
{
  config.system.defaults = {
    NSGlobalDomain = {
      _HIHideMenuBar = false;
      AppleFontSmoothing = 2;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      AppleKeyboardUIMode = 3;
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
      InitialKeyRepeat = if cfg.keyboard.disableKeyRepeat then 0 else 25;
      KeyRepeat = if cfg.keyboard.disableKeyRepeat then 0 else 6;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSWindowResizeTime = 0.1;
    };
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    WindowManager = {
      GloballyEnabled = false;
    };
    dock = {
      autohide = true;
      autohide-delay = 999.9;
      autohide-time-modifier = 0.5;
      dashboard-in-overlay = false;
      enable-spring-load-actions-on-all-items = false;
      expose-animation-duration = 1.0;
      expose-group-apps = true;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      mru-spaces = true;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = false;
      showDesktopGestureEnabled = false;
      showhidden = true;
      showMissionControlGestureEnabled = !cfg.manageWindows.enable;
      static-only = false;
      tilesize = 2 * cfg.fontSize;
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
    magicmouse.MouseButtonMode = null;
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 0;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false;
    };

    screencapture = {
      include-date = true;
      show-thumbnail = false;
      target = "file";
      type = "png";
    };
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 5;
    };
    spaces.spans-displays = cfg.manageWindows.enable;
    trackpad = {
      ActuationStrength = 1;
      Clicking = false;
      Dragging = false;
      FirstClickThreshold = 1;
      SecondClickThreshold = 1;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0;
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
}
