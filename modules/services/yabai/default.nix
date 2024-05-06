{ config, ... }:
let cfg = config.chad;
in {
  config = {
    auto_balance = true;
    layout = "bsp";
  };
  inherit (cfg.manageWindows) enable;
  extraConfig = builtins.foldl' (acc: appName: ''
    yabai -m rule --add app='${appName}' manage=off
  '') "" cfg.manageWindows.exclusions;
}

