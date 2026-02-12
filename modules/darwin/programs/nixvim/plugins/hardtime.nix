{ chadLib, config, ... }:
let
  cfg = config.chad;
  allNvimModeIds =
    with chadLib.constants.nvim;
    chadLib.lists.map modes.mapTo.id (
      chadLib.core.attrValues modes.members
    );
in
{
  programs.nixvim.plugins.hardtime = {
    enable = true;
    settings = {
      allow_different_key = false;
      disable_mouse = true;
      disabled_filetypes = [ ];
      disabled_keys = {
        "<Down>" = allNvimModeIds;
        "<Left>" = allNvimModeIds;
        "<Right>" = allNvimModeIds;
        "<Up>" = allNvimModeIds;
      };
      hint = true;
      max_count = if cfg.editor.extremeMeasures then 2 else 4;
      max_time = if cfg.editor.extremeMeasures then 1000 else 500;
      notification = true;
      restriction_mode =
        if cfg.editor.extremeMeasures then "block" else "hint";
    };
  };
}
