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
      InitialKeyRepeat = if cfg.keyboard.disableKeyRepeat then 0 else 25;
      KeyRepeat = if cfg.keyboard.disableKeyRepeat then 0 else 6;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSWindowResizeTime = 0.1;
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
    spaces.spans-displays = cfg.manageWindows.enable;
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
  imports = [
    ./dock.nix
    ./finder.nix
    ./screen-capture.nix
    ./screen-saver.nix
    ./software-update.nix
    ./trackpad.nix
    ./window-manager.nix
  ];
}
