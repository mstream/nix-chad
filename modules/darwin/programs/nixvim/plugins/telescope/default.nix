{ chadLib, config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;

  actions = chadLib.enum.create {
    mappings = {
      id = {
        moveSelectionNext = "move_selection_next";
        moveSelectionPrevious = "move_selection_previous";
        previewScrollingDown = "preview_scrolling_down";
        previewScrollingUp = "preview_scrolling_up";
      };
    };
    memberNames = [
      "moveSelectionNext"
      "moveSelectionPrevious"
      "previewScrollingDown"
      "previewScrollingUp"
    ];
    name = "telescopeActions";
  };

  pickers = chadLib.enum.create {
    mappings = {
      id = {
        files = "find_files";
        gitBranches = "git_branches";
        gitCommits = "git_commits";
        gitLocalChanges = "git_local_changes";
        gitStash = "git_stash";
        vimBuffers = "buffers";
        vimCommands = "commands";
        vimHelp = "help_tags";
        words = "live_grep";
      };
    };
    memberNames = [
      "files"
      "gitBranches"
      "gitCommits"
      "gitLocalChanges"
      "gitStash"
      "vimBuffers"
      "vimCommands"
      "vimHelp"
      "words"
    ];
    name = "telescopePickers";
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
      ui-select = {
        enable = true;
        settings.specific_opts.codeactions = true;
      };
      undo.enable = true;
    };
    keymaps = import ./keymaps.nix { inherit chadLib kms pickers; };
    settings.defaults = import ./defaults.nix {
      inherit actions chadLib kms;
    };
  };
}
