{ config, ... }:
let
  cfg = config.chad;
  inherit (cfg.manageWindows) enable;
  extraConfig = builtins.foldl' (acc: excl: ''
    ${acc}
    yabai -m rule --add app="${excl.app}" title="${excl.title}" manage=off
  '') "" cfg.manageWindows.exclusions;
in
{
  services.yabai = {
    inherit extraConfig;
    # disabling in favour of aerospace
    enable = enable && false;
    config = {
      auto_balance = true;
      layout = "bsp";
    };
  };
}
