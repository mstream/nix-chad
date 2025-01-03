{ lib, ... }:
with lib;
{
  options = {
    chad.keyboard = {
      disableKeyRepeat = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Holding keys does not make characters being typed repeatedly.
        '';
      };
      remapCapsLock = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Treat Caps Lock key as Escape key.
        '';
      };
      remapLeftArrow = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Treat Left Arrow key as Right Control key.
        '';
      };
    };
  };
}
