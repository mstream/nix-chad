{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;

in
{
  programs.nixvim.plugins.trouble = {
    enable = true;
    settings = {
      auto_close = true;
      auto_preview = true;
      auto_refresh = true;
      focus = false;
      follow = true;
      indent_guides = true;
      keys = with kms.categorized.debug.suffixes; {
        ${toggleDiagnosticsWindow} = "toggle_preview";
      };
      max_items = 200;
      multiline = true;
      restore = true;
      warn_no_results = true;
    };
  };
}
