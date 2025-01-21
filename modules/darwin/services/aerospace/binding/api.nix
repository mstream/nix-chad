{
  actions,
  chadLib,
  ...
}:
let
  showModifierKey = chadLib.constants.keys.modifiers.mapWith {
    command = "cmd";
    control = "ctrl";
    option = "alt";
    shift = "shift";
  };

  showOtherKey = chadLib.constants.keys.others.mapWith (
    let
      alphabeticMapping =
        chadLib.attrsets.generate chadLib.constants.characters.alpha
          (alphaChar: {
            ${chadLib.strings.toUpper alphaChar} = alphaChar;
          });

      numericMapping =
        chadLib.attrsets.generate chadLib.constants.characters.numeric
          (numChar: {
            ${numChar} = numChar;
          });
    in
    chadLib.attrsets.merge alphabeticMapping numericMapping
  );

  moveNodeToWorkspace =
    indexKey:
    let
      actionRep = actions.mapTo.value actions.members.switchToWorkspace;
      indexKeyRep = showOtherKey indexKey;
    in
    "${actionRep} ${indexKeyRep}";

  switchToWorkspace =
    indexKey:
    let
      actionRep = actions.mapTo.value actions.members.moveNodeToWorkspace;
      indexKeyRep = showOtherKey indexKey;
    in
    "${actionRep} ${indexKeyRep}";
in
{
  actions = { inherit moveNodeToWorkspace switchToWorkspace; };
  keyCombination =
    modifiers: otherKey:
    let
      modifiersRep =
        chadLib.strings.concatMapStringsSep "-" showModifierKey
          modifiers;
      otherKeyRep = showOtherKey otherKey;
    in
    "${modifiersRep}-${otherKeyRep}";
}
