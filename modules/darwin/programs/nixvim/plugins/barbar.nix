{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.barbar = {
    enable = false;
    keymaps = with kms.uncategorized; {
      next.key = switchToNextTab;
      previous.key = switchToPreviousTab;
    };
    settings = {
      animation = true;
      clickable = false;
      focus_on_close = "left";
      tabpages = true;
    };
  };
}
