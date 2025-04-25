{ chadLib, ... }:
let
  validators = with chadLib.yants; rec {
    mkCategorizedOptionsGroup = defun [
      string
      string
      (attrs suffixEntry)
      (attrs any)
    ];
    sequenceEntry = {
      description = string;
      sequence = string;
    };
    suffixEntry = struct "suffixEntry" {
      description = string;
      suffix = string;
    };
  };

  mkUncategorizedSequenceOption =
    description: default:
    chadLib.options.mkOption {
      inherit default description;
      type = with chadLib.types; str;
    };

  mkUncategorizedOptionsGroup = chadLib.core.mapAttrs (
    chadLib.functions.constant (
      { description, sequence }:
      mkUncategorizedSequenceOption description sequence
    )
  );

  mkCategorizedSuffixOption =
    prefix:
    { default, description }:
    chadLib.options.mkOption {
      inherit default description;
      apply = s: "<leader>${prefix}${s}";
      type = with chadLib.types; str;
    };

  mkCategorizedPrefixOption =
    prefix: description:
    with chadLib.options;
    mkOption {
      inherit description;
      default = prefix;
      readOnly = true;
      type = with chadLib.types; str;
      visible = true;
    };

  mkCategorizedOptionsGroup = validators.mkCategorizedOptionsGroup (
    prefix: description: entries:
    let
      mkSuffixOption = mkCategorizedSuffixOption prefix;
    in
    {
      prefix = mkCategorizedPrefixOption prefix description;
      suffixes = chadLib.core.mapAttrs (chadLib.functions.constant (
        { description, suffix }:
        mkSuffixOption {
          inherit description;
          default = suffix;
        }
      )) entries;
    }
  );
in
{
  categorized = {
    close = mkCategorizedOptionsGroup "x" "Closing things." {
      currentBuffer = {
        description = "close the current buffer";
        suffix = "bc";
      };
    };

    comment = mkCategorizedOptionsGroup "/" "Commenting things." {
      addEndOfLine = {
        description = "add at the end of line";
        suffix = "lA";
      };
      addLineAbove = {
        description = "add line above";
        suffix = "lO";
      };
      addLineBelow = {
        description = "add line below";
        suffix = "lo";
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
      codeDefinitions = {
        suffix = "cd";
        description = "code definitions";
      };
      codeImplementations = {
        suffix = "ci";
        description = "code implementations";
      };
      codeReferences = {
        suffix = "cr";
        description = "code references";
      };
      codeTypeDefinitions = {
        suffix = "ct";
        description = "code type definitions";
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
    jumpToNextDiagnostic = {
      description = "Jump to a line with the next diagnostic message.";
      sequence = "]d";
    };
    jumpToPreviousDiagnostic = {
      description = "Jump to a line with the previous diagnostic message.";
      sequence = "[d";
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
      description = "Sroll content down (half a page)";
      sequence = "<C-d>";
    };
    scrollDownFullPage = {
      description = "Sroll content down (full page)";
      sequence = "<C-f>";
    };
    scrollUp = {
      description = "Scroll content up (half a page)";
      sequence = "<C-u>";
    };
    scrollUpFullPage = {
      description = "Scroll content up (full page)";
      sequence = "<C-b>";
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
