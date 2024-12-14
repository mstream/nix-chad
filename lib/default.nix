{ pkgs, yants, ... }:
pkgs.lib.extend (
  final: prev:
  let
    extension = {
      inherit yants;
      core = builtins;
      enum = import ./enum.nix {
        inherit yants;
        lib = final;
      };
      lua = import ./lua.nix {
        inherit pkgs;
        lib = final;
      };
    };
    duplicatedKeys = builtins.attrNames (
      builtins.intersectAttrs prev extension
    );
  in
  if duplicatedKeys == [ ] then
    extension
  else
    throw ''
      Can't merge attribute sets because of duplicated keys:
      ${builtins.toString duplicatedKeys}
    ''
)
