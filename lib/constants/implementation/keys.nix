chadLib:
let
  modifiers = chadLib.enum.create {
    mappings = {
      mask = {
        command = 1048576;
        control = 262144;
        option = 524288;
        shift = 131072;
      };
    };
    memberNames = [
      "command"
      "control"
      "option"
      "shift"
    ];
    name = "modifierKeys";
  };

  others = chadLib.enum.create {
    mappings = {
      appleScriptKeyCode = {
        "0" = 29;
        "1" = 18;
        "2" = 19;
        "3" = 20;
        "4" = 21;
        "5" = 23;
        "6" = 22;
        "7" = 26;
        "8" = 28;
        "9" = 26;
        "A" = 0;
        "B" = 11;
        "C" = 8;
        "D" = 2;
        "E" = 14;
        "F" = 3;
        "G" = 5;
        "H" = 4;
        "I" = 34;
        "J" = 38;
        "K" = 40;
        "L" = 37;
        "M" = 46;
        "N" = 45;
        "O" = 31;
        "P" = 35;
        "Q" = 12;
        "R" = 15;
        "S" = 1;
        "T" = 17;
        "U" = 32;
        "V" = 9;
        "W" = 13;
        "X" = 7;
        "Y" = 16;
        "Z" = 6;
      };
    };
    memberNames = [
      "0"
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "A"
      "B"
      "C"
      "D"
      "E"
      "F"
      "G"
      "H"
      "I"
      "J"
      "K"
      "L"
      "M"
      "N"
      "O"
      "P"
      "Q"
      "R"
      "S"
      "T"
      "U"
      "V"
      "W"
      "X"
      "Y"
      "Z"
    ];
    name = "otherKeys";
  };
in
{
  inherit modifiers;
  inherit others;
}
