{ targets, ... }:
{
  enable = true;
  goto_next_end = {
    "]C" = targets.mapTo.query targets.members.classOuter;
    "]F" = targets.mapTo.query targets.members.functionOuter;
  };
  goto_next_start = {
    "]c" = targets.mapTo.query targets.members.classOuter;
    "]f" = targets.mapTo.query targets.members.functionOuter;
  };
  goto_previous_end = {
    "[C" = targets.mapTo.query targets.members.classOuter;
    "[F" = targets.mapTo.query targets.members.functionOuter;
  };
  goto_previous_start = {
    "[c" = targets.mapTo.query targets.members.classOuter;
    "[f" = targets.mapTo.query targets.members.functionOuter;
  };
  set_jumps = true;
}
