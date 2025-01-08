{ lib, ... }:
with lib;
let
  keyMappingModule = {
    options = {
      combination = mkOption {
        type = types.str;
        readOnly = true;
        visible = false;
      };
      description = mkOption {
        type = types.str;
        readOnly = true;
        visible = false;
      };
    };
  };
  keyMappingOption =
    description:
    mkOption {
      inherit description;
      type = types.submodule keyMappingModule;
      readOnly = true;
      visible = false;
    };
  keyMappings = {
    close = {
      currentBuffer = {
        combination = "bc";
        description = "close the current buffer";
      };
    };
    comment = {
      addLineAbove = {
        combination = "lO";
        description = "add line above";
      };
      addLineBelow = {
        combination = "lo";
        description = "add line below";
      };
      addEndOfLine = {
        combination = "lA";
        description = "add at the end of line";
      };
      block = {
        combination = "b";
        description = "block operator-pending";
      };
      line = {
        combination = "l";
        description = "line operator-pending";
      };
      toggleBlock = {
        combination = "tb";
        description = "toggle block";
      };
      toggleLine = {
        combination = "tl";
        description = "toggle line";
      };
    };
    directoryTree = {
      focus = {
        combination = "f";
        description = "focus";
      };
      toggle = {
        combination = "t";
        description = "toggle";
      };
    };
    find = {
      definitions = {
        combination = "d";
        description = "definitions";
      };
      files = {
        combination = "f";
        description = "files";
      };
      gitBranches = {
        combination = "gb";
        description = "Git branches";
      };
      gitCommits = {
        combination = "gc";
        description = "Git commits";
      };
      gitLocalChanges = {
        combination = "gl";
        description = "Git local changes";
      };
      gitStash = {
        combination = "gs";
        description = "Git stashed changes";
      };
      implementations = {
        combination = "i";
        description = "implementations";
      };
      vimBuffers = {
        combination = "vb";
        description = "Vim buffers";
      };
      vimCommands = {
        combination = "vc";
        description = "Vim commands";
      };
      vimHelp = {
        combination = "vh";
        description = "Vim help topics";
      };
      words = {
        combination = "w";
        description = "words across files";
      };
    };
    goTo = {
      declaration = {
        combination = "D";
        description = "declaration";
      };
      definition = {
        combination = "d";
        description = "definition";
      };
      implementation = {
        combination = "i";
        description = "implementation";
      };
      nextProblem = {
        combination = "]";
        description = "next problem";
      };
      previousProblem = {
        combination = "[";
        description = "previous problem";
      };
    };
    refactor = {
      action = {
        combination = "a";
        description = "action";
      };
      format = {
        combination = "f";
        description = "format";
      };
      name = {
        combination = "n";
        description = "name";
      };
    };
    topLevel = {
      cancel = {
        combination = "<ESC>";
        description = "Cancels current selection or mode.";
      };
      moveToBottomWindow = {
        combination = "<C-j>";
        description = "Move to window on the bottom";
      };
      moveToLeftWindow = {
        combination = "<C-h>";
        description = "Move to window on the left";
      };
      moveToRightWindow = {
        combination = "<C-l>";
        description = "Move to window on the right";
      };
      moveToTopWindow = {
        combination = "<C-k>";
        description = "Move to window on the top";
      };
      scrollDown = {
        combination = "<C-d>";
        description = "Sroll content down";
      };
      scrollUp = {
        combination = "<C-u>";
        description = "Scroll content up";
      };
      selectNext = {
        combination = "<C-n>";
        description = "Select next item on a list";
      };
      selectPrevious = {
        combination = "<C-p>";
        description = "Select previous item on a list";
      };
      showKeyMappings = {
        combination = "\\";
        description = "Show key mappings";
      };
      showSymbolInfo = {
        combination = "K";
        description = "Show information about the symbol under the cursor";
      };
      switchToNextTab = {
        combination = "<TAB>";
        description = "switch to next tab";
      };
      switchToPreviousTab = {
        combination = "<S-TAB>";
        description = "switch to previous tab";
      };

    };
    select = {
      decrement = {
        combination = "d";
        description = "decrement selection";
      };
      increment = {
        combination = "i";
        description = "increment selection";
      };
      initialize = {
        combination = "s";
        description = "initialize selection";
      };
    };
  };
in
{
  options = {
    chad.editor = {
      keyMappings = builtins.mapAttrs (
        _: categoryVal:
        builtins.mapAttrs (
          _: { description, ... }: keyMappingOption description
        ) categoryVal
      ) keyMappings;
      documentWidth = mkOption {
        type = types.int;
        default = 72;
        description = ''
          Ideal maximum document's width measured in number of characters.
        '';
      };
      lineNumbering = mkOption {
        type = types.enum [
          "absolute"
          "relative"
        ];
        default = "relative";
        description = ''
          Absolute: line numbers counted from the beginning of the document
          Relative: line numbers counted from the current cursor position
        '';
      };
      tabWidth = mkOption {
        type = types.int;
        default = 2;
        description = ''
          Tabulation width measured in number of characters.
        '';
      };
    };
  };
  config = {
    chad.editor = {
      inherit keyMappings;
    };
  };
}
