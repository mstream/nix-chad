{ chadLib, pkgs, ... }:
{ evaluatedModules }:
let
  neovimKeymapConfig = evaluatedModules.config.chad.editor.keyMappings;

  neovimKeymaps = {
    "Comment" = chadLib.core.map (
      { description, combination }:
      {
        combination = "c${combination}";
        description = "Comment ${description}";
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.comment);
    "Directory Tree" = chadLib.core.map (
      { description, combination }:
      {
        combination = "t${combination}";
        description = "Directory tree ${description}";
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.directoryTree);
    "Find" = chadLib.core.map (
      { description, combination }:
      {
        combination = "f${combination}";
        description = "Find ${description}";
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.find);
    "Go To" = chadLib.core.map (
      { description, combination }:
      {
        combination = "g${combination}";
        description = "Go to ${description}";
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.goTo);
    "Refactor" = chadLib.core.map (
      { description, combination }:
      {
        combination = "r${combination}";
        description = "Refactor ${description}";
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.refactor);
    "Select" = chadLib.core.map (
      { description, combination }:
      {
        combination = "s${combination}";
        description = "Select ${description}";
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.select);
    "Miscellaneous" = chadLib.core.map (
      { description, combination }:
      {
        inherit description combination;
      }
    ) (chadLib.core.attrValues neovimKeymapConfig.topLevel);
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
