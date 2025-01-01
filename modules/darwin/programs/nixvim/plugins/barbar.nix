{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.barbar = {
    enable = true;
    keymaps = {
      next.key = kms.topLevel.switchToNextTab.combination;
      previous.key = kms.topLevel.switchToPreviousTab.combination;
    };
    settings = {
      animation = true;
      clickable = false;
      focus_on_close = "left";
      tabpages = true;
    };
  };
}
