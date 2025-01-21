{ chadLib, ... }:
let
  keyCombinationSpecModule = {
    options = with chadLib.options; {
      modifierKeys = mkOption {
        type =
          with chadLib.types;
          listOf (
            enum (chadLib.core.attrValues chadLib.constants.keys.modifiers.members)
          );
      };
      otherKey = mkOption {
        type =
          with chadLib.types;
          enum (chadLib.core.attrValues chadLib.constants.keys.others.members);
      };
    };
  };

  enabledShortcuts = {
    ${chadLib.shortcuts.api.actions.members.screenshot} = {
      modifierKeys = with chadLib.constants.keys.modifiers.members; [
        command
        shift
      ];
      otherKey = chadLib.constants.keys.others.members."S";
    };
  };
in
{
  options.chad.keyboard = with chadLib.options; {
    disableKeyRepeat = mkOption {
      default = true;
      description = ''
        Holding keys does not make characters being typed repeatedly.
      '';
      type = with chadLib.types; bool;
    };
    remapCapsLock = mkOption {
      default = true;
      description = ''
        Treat Caps Lock key as Escape key.
      '';
      type = with chadLib.types; bool;
    };
    remapLeftArrow = mkOption {
      default = false;
      description = ''
        Treat Left Arrow key as Right Control key.
      '';
      type = with chadLib.types; bool;
    };
    shortcuts = mkOption {
      default = enabledShortcuts;
      readOnly = true;
      visible = true;
      type = with chadLib.types; attrsOf (submodule keyCombinationSpecModule);
    };
  };
}
