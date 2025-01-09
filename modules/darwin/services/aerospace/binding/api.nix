{
  actions,
  chadLib,
  ...
}:
let
  specialKeyMappings = {
    command = "cmd";
    control = "ctrl";
    option = "alt";
    return = throw "unsupported key";
    shift = "shift";
  };

  numberKeyMappings =
    chadLib.attrsets.generate (chadLib.lists.range 0 9)
      (
        index:
        let
          indexRep = chadLib.core.toString index;
        in
        {
          "number${indexRep}" = indexRep;
        }
      );

  showKeyValue = chadLib.constants.keys.mapWith (
    chadLib.attrsets.merge specialKeyMappings numberKeyMappings
  );

  moveNodeToWorkspace =
    indexKey:
    let
      actionRep = actions.mapTo.value actions.members.switchToWorkspace;
      indexKeyRep = showKeyValue indexKey;
    in
    "${actionRep} ${indexKeyRep}";

  switchToWorkspace =
    indexKey:
    let
      actionRep = actions.mapTo.value actions.members.moveNodeToWorkspace;
      indexKeyRep = showKeyValue indexKey;
    in
    "${actionRep} ${indexKeyRep}";
in
{
  actions = { inherit moveNodeToWorkspace switchToWorkspace; };
  keyCombination = chadLib.strings.concatMapStringsSep "-" showKeyValue;
}
