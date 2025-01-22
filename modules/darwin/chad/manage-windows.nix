{ chadLib, ... }:
let
  windowExclusionModule = {
    options = with chadLib.options; {
      app = mkOption {
        type = with chadLib.types; str;
        example = "^Discord$";
        description = ''
          Regex for application name.
        '';
      };
      title = mkOption {
        type = with chadLib.types; str;
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
  options = with chadLib.options; {
    chad.manageWindows = {
      enable = mkOption {
        type = with chadLib.types; bool;
        default = false;
        description = ''
          Keep windows occupy maximum available share of space on desktop.
          Uses own emulation of multiple desktops/spaces.
        '';
      };
      # TODO: migrate from yabai to aerospace
      exclusions = mkOption {
        type = with chadLib.types; listOf (submodule windowExclusionModule);
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
