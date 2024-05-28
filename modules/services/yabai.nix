{ config, ... }:
let
  cfg = config.chad;
  extraConfig = builtins.foldl' (acc: excl: ''
    ${acc}
    yabai -m rule --add app="${excl.app}" title="${excl.title}" manage=off
  '') "" cfg.manageWindows.exclusions;
in {
      services.yabai = {
        inherit extraConfig;
        inherit (cfg.manageWindows) enable;
        config = {
          auto_balance = true;
          layout = "bsp";
        };
    };
}

