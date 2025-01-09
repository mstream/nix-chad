implementation:
let
  colors = implementation.create {
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
  testStandardMapping = {
    expr = colors.mapTo.singleLetter colors.members.green;
    expected = "G";
  };
  testCustomMapping = {
    expr = colors.mapWith {
      blue = "sky";
      green = "grass";
      red = "rose";
    } colors.members.green;
    expected = "grass";
  };
}
