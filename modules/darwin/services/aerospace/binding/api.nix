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
    chadLib.attrsets.generate (chadLib.lists.range 0 9) (
      index:
      let
        indexRep = chadLib.core.toString index;
      in
      {
        "number${indexRep}" = indexRep;
      }
    )
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
