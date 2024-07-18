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
      showKeyMappings = {
        combination = "\\";
        description = "Show key mappings";
      };
      showSymbolInfo = {
        combination = "K";
        description = "Show information about the symbol under the cursor";
      };
    };
  };
in
{
  options = {
    chad.editor = {
      keyMappings = builtins.mapAttrs (
        _: categoryVal:
        builtins.mapAttrs (_: { description, ... }: keyMappingOption description) categoryVal
      ) keyMappings;
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
    };
  };
  config = {
    chad.editor = {
      inherit keyMappings;
    };
  };
}
