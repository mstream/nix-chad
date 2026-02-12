{ chadLib, config, ... }:
let
  cfg = config.chad;
in
{
  options = with chadLib.options; {
    chad.editor = {
      extremeMeasures = mkOption {
        type = with chadLib.types; bool;
        default = false;
        description = ''
          Make editor block repetitive actions that could be replaced
          with more robust alternative.
        '';
      };
      keyMappings = import ./key-mappings.nix {
        inherit chadLib;
        inherit (cfg)
          moveDownKey
          moveLeftKey
          moveRightKey
          moveUpKey
          scrollDownKey
          scrollUpKey
          selectNextKey
          selectPreviousKey
          ;
      };
      documentWidth = mkOption {
        type = with chadLib.types; int;
        default = 72;
        description = ''
          Ideal maximum document's width measured in number of characters.
        '';
      };
      lineNumbering = mkOption {
        type =
          with chadLib.types;
          enum [
            "absolute"
            "relative"
          ];
        default = "relative";
        description = ''
          Absolute: line numbers counted from the beginning of the document
          Relative: line numbers counted from the current cursor position
        '';
      };
      tabWidth = mkOption {
        type = with chadLib.types; int;
        default = 2;
        description = ''
          Tabulation width measured in number of characters.
        '';
      };
    };
  };
}
