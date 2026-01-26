{ config, ... }:
let
  cfg = config.chad;
in
{
  config.system.defaults.NSGlobalDomain = {
    _HIHideMenuBar = false;
    "com.apple.keyboard.fnState" = null;
    "com.apple.mouse.tapBehavior" = null;
    "com.apple.sound.beep.feedback" = 1;
    "com.apple.sound.beep.volume" = 0.0;
    "com.apple.springing.delay" = 0.5;
    "com.apple.springing.enabled" = true;
    "com.apple.swipescrolldirection" = cfg.mouse.naturalScrollDirection;
    "com.apple.trackpad.enableSecondaryClick" = true;
    "com.apple.trackpad.forceClick" = false;
    "com.apple.trackpad.trackpadCornerClickBehavior" = null;
    "com.apple.trackpad.scaling" = 1.0;
    AppleFontSmoothing = 2;
    AppleICUForce24HourTime = true;
    AppleIconAppearanceTheme = "RegularDark";
    AppleInterfaceStyle = "Dark";
    AppleInterfaceStyleSwitchesAutomatically = false;
    AppleKeyboardUIMode = 2;
    AppleEnableMouseSwipeNavigateWithScrolls = true;
    AppleEnableSwipeNavigateWithScrolls = true;
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    ApplePressAndHoldEnabled = false;
    AppleScrollerPagingBehavior = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = false;
    AppleShowScrollBars = "WhenScrolling";
    AppleSpacesSwitchOnActivate = true;
    AppleTemperatureUnit = "Celsius";
    AppleWindowTabbingMode = "always";
    InitialKeyRepeat = if cfg.keyboard.disableKeyRepeat then 0 else 25;
    KeyRepeat = if cfg.keyboard.disableKeyRepeat then 0 else 6;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticInlinePredictionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    NSAutomaticWindowAnimationsEnabled = true;
    NSDisableAutomaticTermination = true;
    NSDocumentSaveNewDocumentsToCloud = true;
    NSNavPanelExpandedStateForSaveMode = false;
    NSNavPanelExpandedStateForSaveMode2 = false;
    NSScrollAnimationEnabled = true;
    NSStatusItemSelectionPadding = 6;
    NSStatusItemSpacing = 12;
    NSTableViewDefaultSizeMode = 3;
    NSTextShowsControlCharacters = false;
    NSUseAnimatedFocusRing = true;
    NSWindowResizeTime = 0.1;
    NSWindowShouldDragOnGesture = false;
    PMPrintingExpandedStateForPrint = false;
    PMPrintingExpandedStateForPrint2 = false;
  };
}
