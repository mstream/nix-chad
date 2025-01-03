{ lib, ... }:
with lib;
{
  options = {
    chad.software = {
      openSourceOnly = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Restricts software to Open Source only.
        '';
      };
    };
  };
}
