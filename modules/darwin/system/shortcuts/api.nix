{ chadLib, ... }:
let
  keyCodes = {
    "A" = 0;
    "S" = 1;
    "D" = 2;
    "F" = 3;
    "H" = 4;
    "G" = 5;
    "Z" = 6;
    "X" = 7;
    "C" = 8;
    "V" = 9;
    "B" = 11;
    "Q" = 12;
    "W" = 13;
    "E" = 14;
    "R" = 15;
    "Y" = 16;
    "T" = 17;
    "1" = 18;
    "2" = 19;
    "3" = 20;
    "4" = 21;
    "6" = 22;
    "5" = 23;
    "=" = 24;
    "9" = 25;
    "7" = 26;
    "-" = 27;
    "8" = 28;
    "0" = 29;
    "]" = 30;
    "O" = 31;
    "U" = 32;
    "[" = 33;
    "I" = 34;
    "P" = 35;
    "L" = 37;
    "J" = 38;
    "'" = 39;
    "K" = 40;
    ";" = 41;
    "\\" = 42;
    "," = 43;
    "/" = 44;
    "N" = 45;
    "M" = 46;
    "." = 47;
    "`" = 50;

    "return" = 36;
    "tab" = 48;
    "space" = 49;
    "delete" = 51;
    "escape" = 53;
    "left" = 123;
    "right" = 124;
    "down" = 125;
    "up" = 126;

    "f17" = 64;
    "f18" = 79;
    "f19" = 80;
    "f20" = 90;
    "f5" = 96;
    "f6" = 97;
    "f7" = 98;
    "f3" = 99;
    "f8" = 100;
    "f9" = 101;
    "f11" = 103;
    "f13" = 105;
    "f16" = 106;
    "f14" = 107;
    "f10" = 109;
    "f12" = 111;
    "f15" = 113;
    "f4" = 118;
    "f2" = 120;
    "f1" = 122;

    "keypad." = 65;
    "keypad*" = 67;
    "keypad+" = 69;
    "keypadClear" = 71;
    "keypad/" = 75;
    "keypadEnter" = 76;
    "keypad-" = 78;
    "keypad=" = 81;
    "keypad0" = 82;
    "keypad1" = 83;
    "keypad2" = 84;
    "keypad3" = 85;
    "keypad4" = 86;
    "keypad5" = 87;
    "keypad6" = 88;
    "keypad7" = 89;
    "keypad8" = 91;
    "keypad9" = 92;
  };

  modifierKeyMask = chadLib.constants.keys.modifiers.mapWith {
    command = 1048576;
    control = 262144;
    option = 524288;
    shift = 131072;
  };

  reverseLookup =
    key:
    let
      keys = chadLib.core.attrNames keyCodes;
      matchingKeys = chadLib.core.filter (k: keyCodes.${k} == key) keys;
    in
    if matchingKeys == [ ] then null else chadLib.core.head matchingKeys;

  combinationToAscii =
    modifierKeys: otherKey:
    let
      includesModifierKey = key: chadLib.core.any (k: k == key) modifierKeys;
      includesCommand = includesModifierKey chadLib.constants.keys.modifiers.command;
      includesControl = includesModifierKey chadLib.constants.keys.modifiers.control;
      includesOption = includesModifierKey chadLib.constants.keys.modifiers.option;
      isAsciish =
        key: (key >= 0 && key < 36) || (key >= 37 && key < 48) || (key == 50);
    in
    if
      (
        !includesControl
        && !(includesCommand && includesOption)
        && isAsciish otherKey
      )
    then
      lib.strings.charToInt (lib.strings.toLower (reverseLookup otherKey))
    else if (!includesControl && code == 36) then
      10
    else if (!includesControl && code == 48) then
      9
    else if (!includesControl && code == 49) then
      32
    else if (!includesControl && code == 51) then
      127
    else
      65535;

  keyCombination = modifierKeys: otherKey: {
    enabled = true;
    type = "standard";
    value = {
      parameters = [
        (combinationToAscii { inherit modifierKeys otherKey; })
        otherKey
        (chadLib.core.foldl' (
          acc: modifierKey: acc + modifierKeyMask modifierKey
        ) 0 modifierKeys)

        (chadLib.pipe modifierMask [
          (chadLib.attrsets.filterAttrs (
            mod: _: chadLib.attrsets.getAttr mod modifierKeys
          ))
          chadLib.attrsets.attrValues
          (chadLib.lists.foldl' chadLib.trivial.add 0)
        ])
      ];
    };
  };

in
{
  inherit actionKey keyCombination;
}
