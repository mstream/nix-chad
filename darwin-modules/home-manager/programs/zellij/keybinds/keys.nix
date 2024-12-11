{ modes, pkgs, ... }:
with pkgs.lib;
let
  kdlKey =
    {
      args ? [ ],
      name,
    }:
    let
      argToString =
        arg: if isString arg then "\"${arg}\"" else "${toString arg}";

      argsString = strings.concatMapStringsSep " " argToString args;
    in
    "${name} ${argsString}";
  showModeKey = modes.match {
    enterSearch = "entersearch";
    locked = "locked";
    move = "move";
    normal = "normal";
    pane = "pane";
    renamePane = "renamepane";
    renameTab = "renametab";
    resize = "resize";
    scroll = "scroll";
    search = "search";
    session = "session";
    tab = "tab";
    tmux = "tmux";
  };
  showModeValue = modes.match {
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
  enterSearch = kdlKey { name = showModeKey modes.enums.enterSearch; };
  goToTab =
    tabIndex:
    kdlKey {
      args = [ tabIndex ];
      name = "GoToTab";
    };
  halfPageScrollDown = kdlKey { name = "HalfPageScrollDown"; };
  halfPageScrollUp = kdlKey { name = "HalfPageScrollUp"; };
  moveFocusOrTab =
    direction:
    kdlKey {
      args = [ direction ];
      name = "MoveFocusOrTab";
    };
  newTab = kdlKey { name = "NewTab"; };
  normal = kdlKey { name = showModeKey modes.enums.normal; };
  scroll = kdlKey { name = showModeKey modes.enums.scroll; };
  search = kdlKey { name = showModeKey modes.enums.search; };
  searchInput =
    index:
    kdlKey {
      args = [ index ];
      name = "SearchInput";
    };
  sharedExcept =
    modes:
    kdlKey {
      args = map showModeKey modes;
      name = "shared_except";
    };
  switchToMode =
    mode:
    kdlKey {
      args = [ (showModeValue mode) ];
      name = "SwitchToMode";
    };
  tab = kdlKey { name = showModeKey modes.enums.tab; };
  togglePaneFrames = kdlKey { name = "TogglePaneFrames"; };
  toggleTab = kdlKey { name = "ToggleTab"; };
}
