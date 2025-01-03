{ config, ... }:
let
  cfg = config.chad;
  inherit (cfg.manageWindows) enable;
in
{
  services.aerospace = {
    inherit enable;
  };
}
