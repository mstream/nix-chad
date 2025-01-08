{ nixpkgsLib, yants, ... }:
let
  extension = rec {
    inherit yants;
    core = builtins;
    enum = import ./enum.nix { inherit core yants; };
    function = import ./function.nix { inherit nixpkgsLib; };
    lua = import ./lua.nix { inherit core nixpkgsLib; };
  };

  duplicatedKeys = builtins.attrNames (
    builtins.intersectAttrs nixpkgsLib extension
  );
in
if duplicatedKeys == [ ] then
  nixpkgsLib // extension
else
  throw ''
    Can't merge attribute sets because of duplicated keys:
    ${builtins.toString duplicatedKeys}
  ''
