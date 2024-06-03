{ lib, ... }:
with lib;
{
  options = {
    chad.mouse = {
      naturalScrollDirection = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Should content scroll opposite to the swipe/roll direction. 
        '';
      };
    };
  };
}
