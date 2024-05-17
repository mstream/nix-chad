{ config, ... }:
let
  cfg = config.chad;
  extraConfig = builtins.foldl' (acc: excl: ''
    yabai -m rule --add app="${excl.app}" title="${excl.title}" manage=off
  '') "" cfg.manageWindows.exclusions;
in {
  inherit extraConfig;
  inherit (cfg.manageWindows) enable;
  config = {
    auto_balance = true;
    layout = "bsp";
  };
}

