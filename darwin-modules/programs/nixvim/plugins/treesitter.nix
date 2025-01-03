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
        keymaps = {
          init_selection = "<leader>s${kms.select.initialize.combination}";
          node_decremental = "<leader>s${kms.select.decrement.combination}";
          node_incremental = "<leader>s${kms.select.increment.combination}";
        };
      };
      indent.enable = false;
    };
  };
}
