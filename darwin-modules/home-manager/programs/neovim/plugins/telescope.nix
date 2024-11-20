{ osConfig, ... }:
let
  cfg = osConfig.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-d>" = "move_selection_next";
      "<C-u>" = "move_selection_previous";
      "<C-A-d>" = "preview_scrolling_down";
      "<C-A-u>" = "preview_scrolling_up";
      "<leader>f${kms.find.git_branches}" = "git_branches";
      "<leader>f${kms.find.git_commits}" = "git_commits";
      "<leader>f${kms.find.git_local_changes}" = "git_local_changes";
      "<leader>f${kms.find.git_stash}" = "git_stash";
      "<leader>f${kms.find.files}" = "find_files";
      "<leader>f${kms.find.vim_buffers}" = "buffers";
      "<leader>f${kms.find.vim_commands}" = "commands";
      "<leader>f${kms.find.vim_help}" = "help_tags";
      "<leader>f${kms.find.words}" = "live_grep";
    };
  };
}
