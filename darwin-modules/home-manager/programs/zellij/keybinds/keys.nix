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
    normal = "normal";
    search = "search";
    tab = "tab";
  };
  showModeValue = modes.match {
    enterSearch = "EnterSearch";
    locked = "Locked";
    normal = "Normal";
    search = "Search";
    tab = "Tab";
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
  toggleTab = kdlKey { name = "ToggleTab"; };
}
