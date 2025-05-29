{
  actions,
  chadLib,
  directions,
  modes,
  modeGroups,
  searchOptions,
  ...
}:
let
  kdlKey =
    {
      args ? [ ],
      name,
    }:
    let
      argToString =
        arg:
        if chadLib.core.isString arg then
          "\"${arg}\""
        else
          "${chadLib.core.toString arg}";

      argsString = chadLib.strings.concatMapStringsSep " " argToString args;
    in
    "${name} ${argsString}";
  showActionValue = actions.mapWith {
    breakPane = "BreakPane";
    closeFocus = "CloseFocus";
    closeTab = "CloseTab";
    goToTab = "GoToTab";
    halfPageScrollDown = "HalfPageScrollDown";
    halfPageScrollUp = "HalfPageScrollUp";
    moveFocus = "MoveFocus";
    newPane = "NewPane";
    newTab = "NewTab";
    scrollDown = "ScrollDown";
    scrollUp = "ScrollUp";
    search = "Search";
    searchInput = "SearchInput";
    searchToggleOption = "SearchToggleOption";
    switchToMode = "SwitchToMode";
    toggleFocusFullScreen = "ToggleFocusFullscreen";
    togglePaneFrames = "TogglePaneFrames";
    toggleTab = "ToggleTab";
  };
  showDirectionValue = directions.mapWith {
    down = "Down";
    left = "Left";
    right = "Right";
    up = "Up";
  };
  showModeValue = modes.mapWith {
    enterSearch = "EnterSearch";
    locked = "Locked";
    move = "Move";
    normal = "Normal";
    pane = "Pane";
    renamePane = "RenamePane";
    renameTab = "RenameTab";
    resize = "Resize";
    scroll = "Scroll";
    search = "Search";
    session = "Session";
    tab = "Tab";
    tmux = "Tmux";
  };
  showSearchOptionValue = searchOptions.mapWith {
    caseSensitivity = "CaseSensitivity";
  };
in
{
  bind =
    combinations:
    kdlKey {
      args = combinations;
      name = "bind";
    };
  breakPane = kdlKey {
    name = showActionValue actions.members.breakPane;
  };
  closeFocus = kdlKey {
    name = showActionValue actions.members.closeFocus;
  };
  closeTab = kdlKey {
    name = showActionValue actions.members.closeTab;
  };
  enterSearch = kdlKey {
    name = modes.mapTo.key modes.members.enterSearch;
  };
  goToTab =
    tabIndex:
    kdlKey {
      args = [ tabIndex ];
      name = showActionValue actions.members.goToTab;
    };
  halfPageScrollDown = kdlKey {
    name = showActionValue actions.members.halfPageScrollDown;
  };
  halfPageScrollUp = kdlKey {
    name = showActionValue actions.members.halfPageScrollUp;
  };
  locked = kdlKey { name = modes.mapTo.key modes.members.locked; };
  moveFocus =
    direction:
    kdlKey {
      args = [
        (showDirectionValue direction)
      ];
      name = showActionValue actions.members.moveFocus;
    };

  newPane = kdlKey { name = showActionValue actions.members.newPane; };
  newTab = kdlKey { name = showActionValue actions.members.newTab; };
  normal = kdlKey { name = modes.mapTo.key modes.members.normal; };
  pane = kdlKey { name = modes.mapTo.key modes.members.pane; };
  scroll = kdlKey { name = modes.mapTo.key modes.members.scroll; };
  scrollDown = kdlKey {
    name = showActionValue actions.members.scrollDown;
  };
  scrollUp = kdlKey { name = showActionValue actions.members.scrollUp; };
  search = kdlKey { name = modes.mapTo.key modes.members.search; };
  searchDown = kdlKey {
    args = [ "down" ];
    name = showActionValue actions.members.search;
  };
  searchUp = kdlKey {
    args = [ "up" ];
    name = showActionValue actions.members.search;
  };
  searchInput =
    index:
    kdlKey {
      args = [ index ];
      name = showActionValue actions.members.searchInput;
    };
  searchToggleOption =
    option:
    kdlKey {
      args = [ (showSearchOptionValue option) ];
      name = showActionValue actions.members.searchToggleOption;
    };
  sharedAmong =
    includedModes:
    kdlKey {
      args = chadLib.core.map modes.mapTo.key includedModes;
      name = modeGroups.mapTo.key modeGroups.members.sharedAmong;
    };
  sharedExcept =
    excludedModes:
    kdlKey {
      args = chadLib.core.map modes.mapTo.key excludedModes;
      name = modeGroups.mapTo.key modeGroups.members.sharedExcept;
    };
  switchToMode =
    mode:
    kdlKey {
      args = [ (showModeValue mode) ];
      name = showActionValue actions.members.switchToMode;
    };
  tab = kdlKey { name = modes.mapTo.key modes.members.tab; };
  toggleFocusFullScreen = kdlKey {
    name = showActionValue actions.members.toggleFocusFullScreen;
  };
  togglePaneFrames = kdlKey {
    name = showActionValue actions.members.togglePaneFrames;
  };
  toggleTab = kdlKey {
    name = showActionValue actions.members.toggleTab;
  };
}
