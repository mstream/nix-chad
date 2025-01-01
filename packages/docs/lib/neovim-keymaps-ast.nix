{ chadLib, keymaps, ... }:
let
  categoryAst =
    categoryTitle: entries:
    chadLib.core.foldl'
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
chadLib.attrsets.foldlAttrs (
  acc: key: val:
  acc ++ (categoryAst key val)
) [ ] keymaps
