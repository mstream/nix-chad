{ targets, ... }:
{
  enable = true;
  includeSurroundingWhitespace = false;
  lookahead = true;
  keymaps = {
    "ac" = targets.mapTo.query targets.members.classOuter;
    "af" = targets.mapTo.query targets.members.functionOuter;
    "ic" = targets.mapTo.query targets.members.classInner;
    "if" = targets.mapTo.query targets.members.functionInner;
  };
}
