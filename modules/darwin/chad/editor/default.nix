{ chadLib, ... }:
{
  options = with chadLib.options; {
    chad.editor = {
      keyMappings = import ./key-mappings.nix { inherit chadLib; };
      documentWidth = mkOption {
        type = types.int;
        default = 72;
        description = ''
          Ideal maximum document's width measured in number of characters.
        '';
      };
      lineNumbering = mkOption {
        type = types.enum [
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
        type = types.int;
        default = 2;
        description = ''
          Tabulation width measured in number of characters.
        '';
      };
    };
  };
}
