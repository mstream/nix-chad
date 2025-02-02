{ chadLib, keymaps, ... }:
let
  validators = with chadLib.yants; rec {
    keymapEntries = list sequenceEntry;
    keymaps = attrs keymapEntries;
    keymapsAst = defun [
      keymaps
      (list (attrs any))
    ];
    sequenceEntry = struct "sequenceEntry" {
      description = string;
      sequence = string;
    };
  };

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
                c = "${sequence} - ${description}";
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
    chadLib.attrsets.foldlAttrs (
      acc: categoryTitle: entries:
      acc ++ (categoryAst categoryTitle entries)
    ) [ ]
  );
in
keymapsAst keymaps
