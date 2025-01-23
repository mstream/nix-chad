{ chadLib, ... }:
let
  mkUncategorizedSequenceOption =
    description: default:
    chadLib.options.makeOption {
      inherit default description;
      type = with chadLib.types; string;
    };

  mkUncategorizedOptionsGroup = chadLib.core.mapAttrs (
    { description, sequence }:
    mkUncategorizedSequenceOption description sequence
  );

  mkCategorizedSuffixOption =
    prefix: description: default:
    chadLib.options.makeOption {
      inherit default description;
      apply = v: "<leader>${prefix}${v}";
      type = with chadLib.types; string;
    };

  mkCategorizedPrefixOption =
    prefix: description:
    with chadLib.options;
    mkOption {
      inherit description;
      default = prefix;
      readOnly = true;
      type = with chadLib.types; string;
      visible = true;
    };

  mkCategorizedOptionsGroup = prefix: description: entries: {
    prefix = mkCategorizedPrefixOption prefix description;
    suffixes = chadLib.core.mapAttrs (
      { description, suffix }:
      mkCategorizedSuffixOption prefix suffix description
    ) entries;
  };

in
{
  categorized = {
    close = mkCategorizedOptionsGroup "x" "Closing things." {
      currentBuffer = {
        description = "close the current buffer";
        suffic = "bc";
      };
    };

    comment = mkCategorizedOptionsGroup "/" "Commenting things." {
      addLineAbove = {
        description = "add line above";
        suffix = "lO";
      };
      addLineBelow = {
        description = "add line below";
        suffix = "lo";
      };
      addEndOfLine = {
        description = "add at the end of line";
        suffix = "lA";
      };
      block = {
        description = "block operator-pending";
        suffix = "b";
      };
      line = {
        description = "line operator-pending";
        suffix = "l";
      };
      toggleBlock = {
        description = "toggle block";
        suffix = "tb";
      };
      toggleLine = {
        description = "toggle line";
        suffix = "tl";
      };
    };

    find = mkCategorizedOptionsGroup "f" "Finding things." {
      definitions = {
        suffix = "d";
        description = "definitions";
      };
      files = {
        suffix = "f";
        description = "files";
      };
      gitBranches = {
        suffix = "gb";
        description = "Git branches";
      };
      gitCommits = {
        suffix = "gc";
        description = "Git commits";
      };
      gitLocalChanges = {
        suffix = "gl";
        description = "Git local changes";
      };
      gitStash = {
        suffix = "gs";
        description = "Git stashed changes";
      };
      implementations = {
        suffix = "i";
        description = "implementations";
      };
      vimBuffers = {
        suffix = "vb";
        description = "Vim buffers";
      };
      vimCommands = {
        suffix = "vc";
        description = "Vim commands";
      };
      vimHelp = {
        suffix = "vh";
        description = "Vim help topics";
      };
      words = {
        suffix = "w";
        description = "words across files";
      };
    };

    goTo = mkCategorizedOptionsGroup "g" "Moving cursor to places." {
      declaration = {
        suffix = "D";
        description = "declaration";
      };
      definition = {
        suffix = "d";
        description = "definition";
      };
      implementation = {
        suffix = "i";
        description = "implementation";
      };
      nextProblem = {
        suffix = "]";
        description = "next problem";
      };
      previousProblem = {
        suffix = "[";
        description = "previous problem";
      };
    };

    refactor = mkCategorizedOptionsGroup "r" "Refactoring code." {
      action = {
        suffix = "a";
        description = "action";
      };
      format = {
        suffix = "f";
        description = "format";
      };
      name = {
        suffix = "n";
        description = "name";
      };
    };

    select = mkCategorizedOptionsGroup "s" "Selecting text." {
      decrement = {
        suffix = "d";
        description = "decrement selection";
      };
      increment = {
        suffix = "i";
        description = "increment selection";
      };
      initialize = {
        suffix = "s";
        description = "initialize selection";
      };
    };
  };
  uncategorized = mkUncategorizedOptionsGroup {
    cancel = {
      description = "Cancels current selection or mode.";
      sequence = "<ESC>";
    };
    confirm = {
      description = "Confirms current selection.";
      sequence = "<CR>";
    };
    moveToBottomWindow = {
      description = "Move to window on the bottom";
      sequence = "<C-j>";
    };
    moveToLeftWindow = {
      description = "Move to window on the left";
      sequence = "<C-h>";
    };
    moveToRightWindow = {
      description = "Move to window on the right";
      sequence = "<C-l>";
    };
    moveToTopWindow = {
      description = "Move to window on the top";
      sequence = "<C-k>";
    };
    scrollDown = {
      description = "Sroll content down";
      sequence = "<C-d>";
    };
    scrollUp = {
      description = "Scroll content up";
      sequence = "<C-u>";
    };
    selectNext = {
      description = "Select next item on a list";
      sequence = "<C-n>";
    };
    selectPrevious = {
      description = "Select previous item on a list";
      sequence = "<C-p>";
    };
    showKeyMappings = {
      description = "Show key mappings";
      sequence = "\\";
    };
    showSymbolInfo = {
      description = "Show information about the symbol under the cursor";
      sequence = "K";
    };
    switchToNextTab = {
      description = "switch to next tab";
      sequence = "<TAB>";
    };
    switchToPreviousTab = {
      description = "switch to previous tab";
      sequence = "<S-TAB>";
    };
  };
}
