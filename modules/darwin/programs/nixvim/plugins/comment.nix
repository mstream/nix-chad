{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.comment = {
    enable = true;
    settings = {
      extra = {
        above = "<leader>/${kms.comment.addLineAbove.combination}";
        below = "<leader>/${kms.comment.addLineBelow.combination}";
        eol = "<leader>/${kms.comment.addEndOfLine.combination}";
      };
      opleader = {
        block = "<leader>/${kms.comment.block.combination}";
        line = "<leader>/${kms.comment.line.combination}";
      };
      padding = true;
      sticky = true;
      toggler = {
        block = "<leader>/${kms.comment.toggleBlock.combination}";
        line = "<leader>/${kms.comment.toggleLine.combination}";
      };
    };
  };
}
