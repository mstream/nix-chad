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
    mkModalOptionGroup = defun [
      string
      (attrs modalOptionEntry)
      (attrs any)
    ];
    modalOptionEntry = struct "modalOptionEntry" {
      description = string;
      sequence = string;
    };
  };

  mkSequenceOption =
    description: sequence:
    chadLib.options.mkOption {
      inherit description;
      default = sequence;
      readOnly = true;
      type = with chadLib.types; str;
      visible = false;
    };

  mkModalOptionGroup = validators.mkModalOptionGroup (
    description: entries: {
      description = chadLib.options.mkOption {
        inherit description;
        default = "";
        readOnly = true;
        type = with chadLib.types; str;
        visible = false;
      };
      entries = chadLib.core.mapAttrs (chadLib.functions.constant (
        { description, sequence }: mkSequenceOption description sequence
      )) entries;
    }
  );

  foldIntegersBetween1And9IntoAttrs = chadLib.attrsets.generate (
    chadLib.lists.range 1 9
  );

  enterSearch = {
    switchToSearchMode = {
      description = "Switch to Search mode";
      sequence = "Enter";
    };

    switchToScrollMode = {
      description = "Switch to Scroll mode";
      sequence = "Esc";
    };
  };
  normal = {
    switchToPaneMode = {
      description = "Switch to Pane mode";
      sequence = "Ctrl a";
    };
    switchToScrollMode = {
      description = "Switch to Scroll mode";
      sequence = "Ctrl s";
    };
    switchToTabMode = {
      description = "Switch to Tab mode";
      sequence = "Ctrl t";
    };
  };
  pane = {
    closePane = {
      description = "Close currently focused pane";
      sequence = "x";
    };
    moveFocusDown = {
      description = "Move focus to a pane to the left";
      sequence = moveDownKey;
    };
    moveFocusLeft = {
      description = "Move focus to a pane to the left";
      sequence = moveLeftKey;
    };
    moveFocusRight = {
      description = "Move focus to a pane to the right";
      sequence = moveRightKey;
    };
    moveFocusUp = {
      description = "Move focus to a pane to the left";
      sequence = moveUpKey;
    };
    newPane = {
      description = "Create a new pane";
      sequence = "n";
    };
    toggleFrames = {
      description = "Toggle frames rendering for panes";
      sequence = "z";
    };
    toggleFullScreen = {
      description = "Toggle fullscreen mode of the focused pane";
      sequence = "f";
    };
  };
  scroll = {
    halfPageScrollDown = {
      description = "Scroll down by half a page";
      sequence = scrollDownKey;
    };
    halfPageScrollUp = {
      description = "Scroll up by half a page";
      sequence = scrollDownKey;
    };
    singleLineScrollDown = {
      description = "Scroll down by a single line";
      sequence = moveDownKey;
    };
    singleLineScrollUp = {
      description = "Scroll up by a single line";
      sequence = moveUpKey;
    };
    switchToEnterSearchMode = {
      description = "Switch to Enter Search mode";
      sequence = "s";
    };
  };
  search = {
    halfPageScrollDown = {
      description = "Scroll down by half a page";
      sequence = scrollDownKey;
    };
    halfPageScrollUp = {
      description = "Scroll up by half a page";
      sequence = scrollUpKey;
    };
    searchDown = {
      description = "Go to the next matched word";
      sequence = selectNextKey;
    };
    searchUp = {
      description = "Go to the previous matched word";
      sequence = selectPreviousKey;
    };
    toggleCaseSensitivity = {
      description = "Toggle word match case sensitivity";
      sequence = "c";
    };
  };
  tab =
    {
      breakPaneIntoNewTab = {
        description = "Break the focused pane into a new tab";
        sequence = "b";
      };
      closeTab = {
        description = "Close the current tab";
        sequence = "x";
      };
      newTab = {
        description = "Create a new tab";
        sequence = "n";
      };
      toggleTab = {
        description = "Switch between two most recently used tabs";
        sequence = "Tab";
      };
    }
    // foldIntegersBetween1And9IntoAttrs (
      idx:
      let
        idxRep = toString idx;
      in
      {
        "goToTab${idxRep}" = {
          description = "Switch to tab under index of ${idxRep}";
          sequence = idxRep;
        };
      }
    );

in
{
  modal = {
    enterSearch = mkModalOptionGroup "Enter Search" enterSearch;
    normal = mkModalOptionGroup "Normal" normal;
    pane = mkModalOptionGroup "Pane" pane;
    scroll = mkModalOptionGroup "Scroll" scroll;
    search = mkModalOptionGroup "Search" search;
    tab = mkModalOptionGroup "Tab" tab;
  };

  shared = chadLib.attrsets.mapAttrs (chadLib.functions.constant (
    entry: mkSequenceOption entry.description "Alt ${entry.sequence}"
  )) pane;
}
