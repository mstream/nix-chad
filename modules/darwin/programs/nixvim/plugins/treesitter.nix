{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    nixGrammars = true;
    nixvimInjections = true;
    settings = {
      highlight.enable = true;
      incremental_selection = {
        enable = true;
        keymaps = with kms.categorized.select; {
          init_selection = initialize;
          node_decremental = decrement;
          node_incremental = increment;
        };
      };
      indent.enable = false;
    };
  };
}
