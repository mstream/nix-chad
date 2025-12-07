chadLib:
let
  nodeTypes = import ./node-types.nix { inherit chadLib; };
  validators = import ./validators.nix { inherit chadLib nodeTypes; };
in
{
  ast = import ./ast.nix { inherit chadLib nodeTypes validators; };
  render = import ./render.nix { inherit chadLib nodeTypes validators; };
}
