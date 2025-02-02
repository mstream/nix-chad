{ chadLib, pkgs, ... }:
{ evaluatedModules }:
let
  neovimKeymapConfig = evaluatedModules.config.chad.editor.keyMappings;

  neovimKeymaps = {
    "Close" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.categorized.close);
    "Comment" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.categorized.comment);
    "Find" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.categorized.find);
    "Go To" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.categorized.goTo);
    "Refactor" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.categorized.refactor);
    "Select" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.categorized.select);
    "Miscellaneous" = chadLib.core.map (sequence: {
      inherit sequence;
      description = "TODO";
    }) (chadLib.core.attrValues neovimKeymapConfig.uncategorized);
  };

  programHeaderAst = programName: {
    t = "Header";
    c = [
      2
      [
        ""
        [ ]
        [ ]
      ]
      [
        {
          t = "Str";
          c = programName;
        }
      ]
    ];
  };

  alacrittyAst = [ (programHeaderAst "Alacritty") ];

  neovimAst =
    [ (programHeaderAst "NeoVim") ]
    ++ (import ./neovim-keymaps-ast.nix {
      inherit chadLib;
      keymaps = neovimKeymaps;
    });

  tocAst = [
    {
      t = "RawBlock";
      c = [
        "html"
        "<!-- toc -->"
      ];
    }
  ];

  keymapsAst = {
    blocks = tocAst ++ alacrittyAst ++ neovimAst;
    meta = { };
    pandoc-api-version = [
      1
      23
      1
    ];
  };

  keymapsJson = pkgs.runCommand "keymaps.json" { } ''
    echo '${chadLib.core.toJSON keymapsAst}' > $out
  '';

  keymapsCommonMark =
    pkgs.runCommand "keymaps.md" { nativeBuildInputs = [ pkgs.pandoc ]; }
      ''
        pandoc ${keymapsJson} --from json --to markdown_strict -o $out
      '';
in
{
  inherit keymapsCommonMark;
}
