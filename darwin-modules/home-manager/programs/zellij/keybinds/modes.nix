{ yants, ... }:
let
  modeNames = [
    "enterSearch"
    "locked"
    "move"
    "normal"
    "pane"
    "renamePane"
    "renameTab"
    "resize"
    "scroll"
    "search"
    "session"
    "tab"
    "tmux"
  ];
  modeEnum = yants.enum "modes" modeNames;
  match = mappings: mode: modeEnum.match mode mappings;
  enums = builtins.foldl' (
    acc: modeName: acc // { ${modeName} = modeEnum modeName; }
  ) { } modeNames;
in
{
  inherit enums match;
}
