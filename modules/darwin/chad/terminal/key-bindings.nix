{ chadLib, ... }:
let
  keyBindingOptions = with chadLib.options; {
    chars = mkOption {
      type = with chadLib.types; str;
      description = ''
        Substitution.
      '';
    };
    key = mkOption {
      type = with chadLib.types; str;
      description = ''
        Key.
      '';
    };
    mods = mkOption {
      type = with chadLib.types; str;
      description = ''
        Modifier key(s).
      '';
    };
  };
in
with chadLib.options;
mkOption {
  type =
    with chadLib.types;
    listOf (submodule {
      options = keyBindingOptions;
    });
  default = [ ];
  example = [
    {
      chars = "\\u000c";
      key = "K";
      mods = "Control";
    }
  ];
  description = ''
    Additional key bindings for terminal emulator. 
  '';
}
