{ chadLib, config, ... }:
let
  cfg = config.chad;
in
{
  options = with chadLib.options; {
    chad.terminal = {
      abbreviations = {
        enable = mkOption {
          type = with chadLib.types; bool;
          default = true;
          description = ''
            Enables expandable command abbreviations.
          '';
        };
        extraAbbreviations = mkOption {
          type = with chadLib.types; attrsOf str;
          default = { };
          example = {
            l = "less";
            gco = "git checkout";
          };
          description = ''
            An attribute set that maps aliases (the top level attribute names
            in this option) to abbreviations. Abbreviations are expanded with
            the longer phrase after they are entered.
          '';
        };
      };
      keyBindings = import ./key-bindings.nix { inherit chadLib; };
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
      zshInitExtra = mkOption {
        type = with chadLib.types; lines;
        default = "";
        example = ''
          export VAR1=val1  
          export VAR2=val2
        '';
        description = ''
          Additional initialization for ZSH sessions.
        '';
      };
    };
  };
}
