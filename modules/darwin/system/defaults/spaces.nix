{ config, ... }:
let
  cfg = config.chad;
in
{
  config.system.defaults.spaces = {
    spans-displays = cfg.manageWindows.enable;
  };
}
