{ lib, ... }:
let
  inherit (import ../lib/enum.nix { inherit lib; }) create;

  colors = create {
    mappings = {
      singleLetter = {
        blue = "B";
        green = "G";
        red = "R";
      };
    };
    memberNames = [
      "blue"
      "green"
      "red"
    ];
    name = "colors";
  };
in
{
  standardMapping = {
    expr = colors.mapTo.singleLetter colors.members.green;
    expected = "G";
  };

  customMapping = {
    expr = colors.mapWith {
      blue = "sky";
      green = "grass";
      red = "rose";
    } colors.members.green;
    expected = "grass";
  };
}
