{ config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;

  actionLuaSnippet = action: {
    __raw = "require('telescope.actions').${action}";
  };

  defaultMappingsOverride = {
    "${kms.topLevel.scrollDown.combination}" = actionLuaSnippet "move_selection_next";
    "${kms.topLevel.scrollUp.combination}" = actionLuaSnippet "move_selection_previous";
    "${kms.topLevel.scrollDownPreview.combination}" = actionLuaSnippet "preview_scrolling_down";
    "${kms.topLevel.scrollUpPreview.combination}" = actionLuaSnippet "preview_scrolling_up";
  };
in
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file-browser.enable = true;
      frecency.enable = true;
      fzf-native.enable = true;
      live-grep-args.enable = true;
      manix.enable = true;
      media-files.enable = true;
      ui-select.enable = true;
      undo.enable = true;
    };
    keymaps = {
      "<leader>f${kms.find.gitBranches.combination}" = "git_branches";
      "<leader>f${kms.find.gitCommits.combination}" = "git_commits";
      "<leader>f${kms.find.gitLocalChanges.combination}" = "git_local_changes";
      "<leader>f${kms.find.gitStash.combination}" = "git_stash";
      "<leader>f${kms.find.files.combination}" = "find_files";
      "<leader>f${kms.find.vimBuffers.combination}" = "buffers";
      "<leader>f${kms.find.vimCommands.combination}" = "commands";
      "<leader>f${kms.find.vimHelp.combination}" = "help_tags";
      "<leader>f${kms.find.words.combination}" = "live_grep";
    };
    settings.defaults = {
      mappings = {
        i = defaultMappingsOverride;
        n = defaultMappingsOverride;
      };
      preview = true;
    };
  };
}
