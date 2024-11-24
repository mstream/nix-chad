{ pkgs, ... }:
let
  keymaps = {
    "Group 1" = [
      {
        combination = "abc";
        description = "do something";
      }
      {
        combination = "def";
        description = "do something else";
      }
    ];
    "Group 2" = [
      {
        combination = "ghi";
        description = "do yet another thing";
      }
    ];
  };
  actualAst = import ../packages/docs/lib/neovim-keymaps-ast.nix {
    inherit keymaps pkgs;
  };
  expectedAst = [
    {
      t = "Header";
      c = [
        3
        [
          ""
          [ ]
          [ ]
        ]
        [
          {
            t = "Str";
            c = "Group 1";
          }
        ]
      ];
    }
    {
      t = "Plain";
      c = [
        {
          t = "Str";
          c = "abc - do something";
        }
      ];
    }
    {
      t = "Plain";
      c = [
        {
          t = "Str";
          c = "def - do something else";
        }
      ];
    }
    {
      t = "Header";
      c = [
        3
        [
          ""
          [ ]
          [ ]
        ]
        [
          {
            t = "Str";
            c = "Group 2";
          }
        ]
      ];
    }
    {
      t = "Plain";
      c = [
        {
          t = "Str";
          c = "ghi - do yet another thing";
        }
      ];
    }
  ];
in
{
  testNeovimKeymapsAst = {
    expected = expectedAst;
    expr = actualAst;
  };
}
