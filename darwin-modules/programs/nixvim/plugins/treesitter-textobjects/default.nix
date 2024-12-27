{ lib, ... }:
let
  targets = lib.enum.create {
    mappings = {
      query = {
        classInner = "@class.inner";
        classOuter = "@class.outer";
        functionInner = "@function.inner";
        functionOuter = "@function.outer";
      };
    };
    memberNames = [
      "classInner"
      "classOuter"
      "functionInner"
      "functionOuter"
    ];
    name = "targets";
  };
in
{
  programs.nixvim.plugins.treesitter-textobjects = {
    enable = true;
    move = import ./move.nix { inherit targets; };
    select = import ./select.nix { inherit targets; };
  };
}
