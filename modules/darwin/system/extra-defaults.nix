# This module includes not yet supported options and is piggibacked
# by darwin's module ability to serialize
# and update these default values.

# TODO: contribute to the project and raise a PR with these options

{ chadLib, config, ... }:
let
  cfg = config.chad;
in
{
  config.system.defaults = {
    dock = {
      showDesktopGestureEnabled = false;
      showMissionControlGestureEnabled = !cfg.manageWindows.enable;
    };
  };

  options.system.defaults = with chadLib.options; {
    dock = {
      showDesktopGestureEnabled = mkOption {
        default = null;
        description = ''
          Spread with thumb and three fingers to show desktop.
        '';
        type = with chadLib.types; types.nullOr types.bool;
      };
      showMissionControlGestureEnabled = mkOption {
        default = null;
        description = ''
          Swipe up with three fingers to enter Mission Control view.
        '';
        type = with chadLib.types; types.nullOr types.bool;
      };
    };
  };
}
