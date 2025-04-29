{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.neoscroll = {
    enable = true;
    settings = {
      cursor_scrolls_alone = true;
      easing_function = "quadratic";
      hide_cursor = true;
      mappings = with kms.uncategorized; [
        scrollDown
        scrollDownFullPage
        scrollUp
        scrollUpFullPage
      ];
      performance_mode = false;
      respect_scrolloff = false;
      stop_eof = true;
    };
  };
}
