{ targets, ... }:
{
  enable = true;
  gotoNextEnd = {
    "]C" = targets.mapTo.query targets.members.classOuter;
    "]F" = targets.mapTo.query targets.members.functionOuter;
  };
  gotoNextStart = {
    "]c" = targets.mapTo.query targets.members.classOuter;
    "]f" = targets.mapTo.query targets.members.functionOuter;
  };
  gotoPreviousEnd = {
    "[C" = targets.mapTo.query targets.members.classOuter;
    "[F" = targets.mapTo.query targets.members.functionOuter;
  };
  gotoPreviousStart = {
    "[c" = targets.mapTo.query targets.members.classOuter;
    "[f" = targets.mapTo.query targets.members.functionOuter;
  };
  setJumps = true;
}
