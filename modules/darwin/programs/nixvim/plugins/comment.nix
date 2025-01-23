{ chadLib, config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;

  keyMappingSettings = with kms.categorized.comment; {
    extra = {
      above = addLineAbove;
      below = addLineBelow;
      eol = addEndOfLine;
    };
    opleader = {
      inherit block line;
    };
    toggler = {
      block = toggleBlock;
      line = toggleLine;
    };
  };
in
{
  programs.nixvim.plugins.comment = {
    enable = true;
    settings = chadLib.attrsets.merge keyMappingSettings {
      padding = true;
      sticky = true;
    };
  };
}
