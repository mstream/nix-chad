{
  directions,
  lib,
  modes,
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
        if lib.core.isString arg then
          "\"${arg}\""
        else
          "${lib.core.toString arg}";

      argsString = lib.strings.concatMapStringsSep " " argToString args;
    in
    "${name} ${argsString}";
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
in
{
  bind =
    combinations:
    kdlKey {
      args = combinations;
      name = "bind";
    };
  closeTab = kdlKey {
    name = "CloseTab";
  };
  enterSearch = kdlKey {
    name = modes.mapTo.key modes.members.enterSearch;
  };
  goToTab =
    tabIndex:
    kdlKey {
      args = [ tabIndex ];
      name = "GoToTab";
    };
  halfPageScrollDown = kdlKey { name = "HalfPageScrollDown"; };
  halfPageScrollUp = kdlKey { name = "HalfPageScrollUp"; };
  locked = kdlKey { name = modes.mapTo.key modes.members.locked; };
  moveFocusOrTab =
    direction:
    kdlKey {
      args = [
        (showDirectionValue direction)
      ];
      name = "MoveFocusOrTab";
    };
  newTab = kdlKey { name = "NewTab"; };
  normal = kdlKey { name = modes.mapTo.key modes.members.normal; };
  scroll = kdlKey { name = modes.mapTo.key modes.members.scroll; };
  search = kdlKey { name = modes.mapTo.key modes.members.search; };
  searchInput =
    index:
    kdlKey {
      args = [ index ];
      name = "SearchInput";
    };
  sharedAmong =
    includedModes:
    kdlKey {
      args = lib.core.map modes.mapTo.key includedModes;
      name = "shared_among";
    };
  sharedExcept =
    excludedModes:
    kdlKey {
      args = lib.core.map modes.mapTo.key excludedModes;
      name = "shared_except";
    };
  switchToMode =
    mode:
    kdlKey {
      args = [ (showModeValue mode) ];
      name = "SwitchToMode";
    };
  tab = kdlKey { name = modes.mapTo.key modes.members.tab; };
  togglePaneFrames = kdlKey { name = "TogglePaneFrames"; };
  toggleTab = kdlKey { name = "ToggleTab"; };
}
