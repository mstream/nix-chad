{
  actions,
  chadLib,
  directions,
  modes,
  modeGroups,
  plugins,
  searchOptions,
  ...
}:
let
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
    chadLib.kdl.key {
      args = combinations;
      name = "bind";
    };
  breakPane = chadLib.kdl.key {
    name = showActionValue actions.members.breakPane;
  };
  closeFocus = chadLib.kdl.key {
    name = showActionValue actions.members.closeFocus;
  };
  closeTab = chadLib.kdl.key {
    name = showActionValue actions.members.closeTab;
  };
  enterSearch = chadLib.kdl.key {
    name = modes.mapTo.key modes.members.enterSearch;
  };
  goToTab =
    tabIndex:
    chadLib.kdl.key {
      args = [ tabIndex ];
      name = showActionValue actions.members.goToTab;
    };
  halfPageScrollDown = chadLib.kdl.key {
    name = showActionValue actions.members.halfPageScrollDown;
  };
  halfPageScrollUp = chadLib.kdl.key {
    name = showActionValue actions.members.halfPageScrollUp;
  };
  locked = chadLib.kdl.key {
    name = modes.mapTo.key modes.members.locked;
  };
  moveFocus =
    direction:
    chadLib.kdl.key {
      args = [
        (showDirectionValue direction)
      ];
      name = showActionValue actions.members.moveFocus;
    };
  newPane = chadLib.kdl.key {
    name = showActionValue actions.members.newPane;
  };
  newTab = chadLib.kdl.key {
    name = showActionValue actions.members.newTab;
  };
  normal = chadLib.kdl.key {
    name = modes.mapTo.key modes.members.normal;
  };
  pane = chadLib.kdl.key { name = modes.mapTo.key modes.members.pane; };
  scroll = chadLib.kdl.key {
    name = modes.mapTo.key modes.members.scroll;
  };
  scrollDown = chadLib.kdl.key {
    name = showActionValue actions.members.scrollDown;
  };
  scrollUp = chadLib.kdl.key {
    name = showActionValue actions.members.scrollUp;
  };
  search = chadLib.kdl.key {
    name = modes.mapTo.key modes.members.search;
  };
  searchDown = chadLib.kdl.key {
    args = [ "down" ];
    name = showActionValue actions.members.search;
  };
  searchUp = chadLib.kdl.key {
    args = [ "up" ];
    name = showActionValue actions.members.search;
  };
  searchInput =
    index:
    chadLib.kdl.key {
      args = [ index ];
      name = showActionValue actions.members.searchInput;
    };
  searchToggleOption =
    option:
    chadLib.kdl.key {
      args = [ (showSearchOptionValue option) ];
      name = showActionValue actions.members.searchToggleOption;
    };
  sharedAmong =
    includedModes:
    chadLib.kdl.key {
      args = chadLib.core.map modes.mapTo.key includedModes;
      name = modeGroups.mapTo.key modeGroups.members.sharedAmong;
    };
  sharedExcept =
    excludedModes:
    chadLib.kdl.key {
      args = chadLib.core.map modes.mapTo.key excludedModes;
      name = modeGroups.mapTo.key modeGroups.members.sharedExcept;
    };
  switchToMode =
    mode:
    chadLib.kdl.key {
      args = [ (showModeValue mode) ];
      name = showActionValue actions.members.switchToMode;
    };
  tab = chadLib.kdl.key { name = modes.mapTo.key modes.members.tab; };
  toggleFocusFullScreen = chadLib.kdl.key {
    name = showActionValue actions.members.toggleFocusFullScreen;
  };
  togglePaneFrames = chadLib.kdl.key {
    name = showActionValue actions.members.togglePaneFrames;
  };
  toggleTab = chadLib.kdl.key {
    name = showActionValue actions.members.toggleTab;
  };
  welcomeScreen = chadLib.kdl.key {
    name = plugins.mapTo.key plugins.members.welcomeScreen;
  };
}
