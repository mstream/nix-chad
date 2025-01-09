chadLib:
let
  modifierKeys = chadLib.enum.create {
    memberNames = [
      "command"
      "control"
      "option"
      "shift"
    ];
    name = "modifierKeys";
  };

  otherKeys = chadLib.enum.create {
    memberNames = [
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
    ];
    name = "otherKeys";
  };
in
{
  implementation = {
    keys = {
      modifiers = modifierKeys;
      others = otherKeys;
    };
  };
  tests = { };
}
