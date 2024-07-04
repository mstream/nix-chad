{ lib, ... }:
with lib;
let
  keyBindingModule = {
    options = {
      chars = mkOption {
        type = types.str;
        description = ''
          Substitution.
        '';
      };
      key = mkOption {
        type = types.str;
        description = ''
          Key.
        '';
      };
      mods = mkOption {
        type = types.str;
        description = ''
          Modifier key(s).
        '';
      };
    };
  };
in
{
  options = {
    chad.terminal = {
      extraAbbreviations = mkOption {
        type = types.attrsOf types.str;
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
      keyBindings = mkOption {
        type = types.listOf (types.submodule keyBindingModule);
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
      };
      zshInitExtra = mkOption {
        type = types.lines;
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
