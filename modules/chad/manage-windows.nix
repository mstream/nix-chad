{ lib, ... }:
with lib;
let
  windowExclusionModule = {
    options = {
      app = mkOption {
        type = types.str;
        example = "^Discord$";
        description = ''
          Regex for application name.
        '';
      };
      title = mkOption {
        type = types.str;
        default = ".*";
        example = ".*Dialog$";
        description = ''
          Regex for window title.
        '';
      };
    };
  };
in
{
  options = {
    chad.manageWindows = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Keep windows occupy maximum available share of space on desktop.
        '';
      };
      exclusions = mkOption {
        type = types.listOf (types.submodule windowExclusionModule);
        default = [ ];
        example = [
          {
            app = "^Discord$";
            title = ".*Dialog$";
          }
        ];
        description = ''
          List of application names for which automatic 
          window management should not be performed.
          It can be figured out using this command:
          ```shell
            yabai -m query --windows
          ```
        '';
      };
    };
  };
}
