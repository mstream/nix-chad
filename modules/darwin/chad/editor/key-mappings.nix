{
  chadLib,
  moveDownKey,
  moveLeftKey,
  moveRightKey,
  moveUpKey,
  scrollDownKey,
  scrollUpKey,
  selectNextKey,
  selectPreviousKey,
  ...
}:
let
  validators = with chadLib.yants; rec {
    mkCategorizedOptionsGroup = defun [
      string
      string
      (attrs suffixEntry)
      (attrs any)
    ];
    mkUncategorizedOptionsGroup = defun [
      (attrs sequenceEntry)
      (attrs any)
    ];
    sequenceEntry = struct "sequenceEntry" {
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
    chadLib.options.mkOption {
      inherit description;
      default = prefix;
      readOnly = true;
      type = with chadLib.types; str;
      visible = false;
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

  mkUncategorizedOptionsGroup = validators.mkUncategorizedOptionsGroup (
    chadLib.core.mapAttrs (
      chadLib.functions.constant (
        { description, sequence }:
        mkUncategorizedSequenceOption description sequence
      )
    )
  );
in
{
  categorized = {
    close = mkCategorizedOptionsGroup "x" "Closing things" {
      currentBuffer = {
        description = "close the current buffer";
        suffix = "bc";
      };
    };

    comment = mkCategorizedOptionsGroup "/" "Commenting things" {
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

    debug = mkCategorizedOptionsGroup "d" "Debug code" {
      toggleDiagnosticsWindow = {
        suffix = "x";
        description = "toggle diagnostics window";
      };
    };

    find = mkCategorizedOptionsGroup "f" "Finding things" {
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

    goTo = mkCategorizedOptionsGroup "g" "Moving cursor to places" {
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

    refactor = mkCategorizedOptionsGroup "r" "Refactoring code" {
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

    select = mkCategorizedOptionsGroup "s" "Selecting text" {
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
      description = "Cancel current selection or mode";
      sequence = "<ESC>";
    };
    confirm = {
      description = "Confirm current selection";
      sequence = "<CR>";
    };
    moveToBottomWindow = {
      description = "Move to window on the bottom";
      sequence = "<C-${moveDownKey}>";
    };
    moveToLeftWindow = {
      description = "Move to window on the left";
      sequence = "<C-${moveLeftKey}>";
    };
    moveToRightWindow = {
      description = "Move to window on the right";
      sequence = "<C-${moveRightKey}>";
    };
    moveToTopWindow = {
      description = "Move to window on the top";
      sequence = "<C-${moveUpKey}>";
    };
    scrollDown = {
      description = "Sroll content down (half a page)";
      sequence = "<C-${scrollDownKey}>";
    };
    scrollDownFullPage = {
      description = "Sroll content down (full page)";
      sequence = "<C-f>";
    };
    scrollUp = {
      description = "Scroll content up (half a page)";
      sequence = "<C-${scrollUpKey}>";
    };
    scrollUpFullPage = {
      description = "Scroll content up (full page)";
      sequence = "<C-b>";
    };
    selectNext = {
      description = "Select next item on a list";
      sequence = "<C-${selectNextKey}>";
    };
    selectPrevious = {
      description = "Select previous item on a list";
      sequence = "<C-${selectPreviousKey}>";
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
