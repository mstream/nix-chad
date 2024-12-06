{ yants, ... }:
let
  modeNames = [
    "enterSearch"
    "locked"
    "normal"
    "search"
    "tab"
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
