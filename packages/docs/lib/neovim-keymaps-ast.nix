{ keymaps, pkgs, ... }:
with pkgs.lib;
let
  categoryAst =
    categoryTitle: entries:
    builtins.foldl'
      (
        acc:
        { combination, description }:
        acc
        ++ [
          {
            t = "Plain";
            c = [
              {
                t = "Str";
                c = "${combination} - ${description}";
              }
            ];
          }
        ]
      )
      [
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
                c = categoryTitle;
              }
            ]
          ];
        }
      ]
      entries;
in
foldlAttrs (
  acc: key: val:
  acc ++ (categoryAst key val)
) [ ] keymaps
