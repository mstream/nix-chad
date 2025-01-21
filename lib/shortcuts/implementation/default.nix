chadLib:
let
  actions = import ./actions.nix { inherit chadLib; };
  disabled = {
    enabled = false;
  };
  keyCombination = import ./key-combination.nix { inherit chadLib; };
in
{
  inherit disabled keyCombination;
  api = {
    inherit actions;
    modifierKeys = chadLib.constants.keys.modifiers.members;
    otherKeys = chadLib.constants.keys.others.members;
  };
}
