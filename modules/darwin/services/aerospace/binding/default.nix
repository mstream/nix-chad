{
  actions,
  chadLib,
  ...
}:
let
  api = import ./api.nix { inherit actions chadLib; };

  keyIndexToKeyBindings = indexKey: {
    ${
      api.keyCombination (
        (with chadLib.constants.keys.members; [
          command
        ])
        ++ [ indexKey ]
      )
    } =
      with api.actions; [ (switchToWorkspace indexKey) ];

    ${
      api.keyCombination (
        (with chadLib.constants.keys.members; [
          command
          control
        ])
        ++ [ indexKey ]
      )
    } =
      with api.actions; [
        (moveNodeToWorkspace indexKey)
        (switchToWorkspace indexKey)
      ];

    ${
      api.keyCombination (
        (with chadLib.constants.keys.members; [
          command
          shift
        ])
        ++ [ indexKey ]
      )
    } =
      with api.actions; [ (moveNodeToWorkspace indexKey) ];
  };

  workspaceIndexKeys = chadLib.core.map (
    index:
    let
      indexRep = chadLib.core.toString index;
    in
    chadLib.constants.keys.members."number${indexRep}"
  ) (chadLib.lists.range 1 9);

  workspaceActions = chadLib.attrsets.generate workspaceIndexKeys keyIndexToKeyBindings;
in
workspaceActions
