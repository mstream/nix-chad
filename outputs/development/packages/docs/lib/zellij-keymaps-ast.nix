{
  chadLib,
  keymaps,
  validators,
  ...
}:
let
  modeAst =
    modeTitle: entries:
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
                c = modeTitle;
              }
            ]
          ];
        }
      ]
      entries;

  keymapsAst = validators.keymapsAst (
    { categorized, uncategorized }:
    let
      modalAst = chadLib.attrsets.foldlAttrs (
        acc: modeTitle: entries:
        acc ++ (modeAst modeTitle entries)
      ) [ ] categorized;
      sharedAst = modeAst "Shared" uncategorized;
    in
    modalAst ++ sharedAst
  );
in
keymapsAst keymaps
