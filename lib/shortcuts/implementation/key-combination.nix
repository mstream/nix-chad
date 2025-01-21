{ chadLib, ... }:
let
  validators = with chadLib.yants; rec {
    keyCombination = defun [
      (list modifierKey)
      otherKey
      keyCombinationSpec
    ];
    keyCombinationSpec = struct "keyCombinationSpec" {
      enabled = bool;
      value = struct "keyCombinationSpecValue" {
        parameters = restrict "3-items long" (
          items: chadLib.core.length items == 3
        ) (list int);
        type = enum [ "standard" ];
      };
    };
    modifierKey = enum (
      chadLib.core.attrValues chadLib.constants.keys.modifiers.members
    );
    otherKey = enum (
      chadLib.core.attrValues chadLib.constants.keys.others.members
    );
  };

  asciiCode = chadLib.functions.compose [
    chadLib.strings.toLower
    chadLib.strings.charToInt
  ];
in
validators.keyCombination (
  modifierKeys: otherKey: {
    enabled = true;
    value = {
      parameters = [
        (asciiCode otherKey)
        (chadLib.constants.keys.others.mapTo.appleScriptKeyCode otherKey)
        (chadLib.core.foldl' (
          acc: modifierKey:
          acc + chadLib.constants.keys.modifiers.mapTo.mask modifierKey
        ) 0 modifierKeys)
      ];
      type = "standard";
    };
  }
)
