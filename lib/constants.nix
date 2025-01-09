chadLib:
let
  keys = chadLib.enum.create {
    memberNames = [
      "command"
      "control"
      "number0"
      "number1"
      "number2"
      "number3"
      "number4"
      "number5"
      "number6"
      "number7"
      "number8"
      "number9"
      "option"
      "return"
      "shift"
    ];
    name = "keys";
  };
in
{
  implementation = {
    inherit keys;
  };
  tests = { };
}
