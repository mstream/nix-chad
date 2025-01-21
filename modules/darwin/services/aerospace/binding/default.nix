{
  actions,
  chadLib,
  ...
}:
let
  api = import ./api.nix { inherit actions chadLib; };

  keyIndexToKeyBindings = indexKey: {
    ${
      api.keyCombination (with chadLib.constants.keys.modifiers.members; [
        command
      ]) indexKey
    } =
      with api.actions; [ (switchToWorkspace indexKey) ];

    ${
      api.keyCombination (with chadLib.constants.keys.modifiers.members; [
        command
        control
      ]) indexKey
    } =
      with api.actions; [
        (moveNodeToWorkspace indexKey)
        (switchToWorkspace indexKey)
      ];

    ${
      api.keyCombination (with chadLib.constants.keys.modifiers.members; [
        command
        shift
      ]) indexKey
    } =
      with api.actions; [ (moveNodeToWorkspace indexKey) ];
  };

  workspaceIndexKeys = chadLib.core.map (
    index:
    let
      indexRep = chadLib.core.toString index;
    in
    chadLib.constants.keys.others.members.${indexRep}
  ) (chadLib.lists.range 1 9);

  workspaceActions = chadLib.attrsets.generate workspaceIndexKeys keyIndexToKeyBindings;
in
workspaceActions
