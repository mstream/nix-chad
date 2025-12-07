{
  chadLib,
  keymaps,
  validators,
  ...
}:
let
  categoryAst =
    categoryTitle: entries:
    chadLib.core.foldl'
      (
        acc:
        { sequence, description }:
        acc
        ++ [
          {
            t = "Plain";
            c = [
              {
                t = "Str";
                c = "${description} - ${sequence}";
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

  keymapsAst = validators.keymapsAst (
    { categorized, uncategorized }:
    let
      categorizedAst = chadLib.attrsets.foldlAttrs (
        acc: categoryTitle: entries:
        acc ++ (categoryAst categoryTitle entries)
      ) [ ] categorized;
      uncategorizedAst = categoryAst "Miscellaneous" uncategorized;
    in
    categorizedAst ++ uncategorizedAst
  );
in
keymapsAst keymaps
