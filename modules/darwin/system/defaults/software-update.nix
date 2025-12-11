{ config, ... }:
let
  cfg = config.chad;
in
{
  config.system.defaults.SoftwareUpdate = {
    AutomaticallyInstallMacOSUpdates = false;
  };
}
