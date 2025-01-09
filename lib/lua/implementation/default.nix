chadLib:
let
  nodeTypes = import ./node-types.nix { inherit chadLib; };
in
{
  api = import ./api.nix { inherit chadLib nodeTypes; };
  render = import ./render.nix { inherit chadLib nodeTypes; };
}
