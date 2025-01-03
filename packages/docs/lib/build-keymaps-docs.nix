{ lib, pkgs, ... }:
{ evaluatedModules }:
let
  neovimKeymapConfig = evaluatedModules.config.chad.editor.keyMappings;

  neovimKeymaps = {
    "Comment" = builtins.map (
      { description, combination }:
      {
        combination = "c${combination}";
        description = "Comment ${description}";
      }
    ) (builtins.attrValues neovimKeymapConfig.comment);
    "Directory Tree" = builtins.map (
      { description, combination }:
      {
        combination = "t${combination}";
        description = "Directory tree ${description}";
      }
    ) (builtins.attrValues neovimKeymapConfig.directoryTree);
    "Find" = builtins.map (
      { description, combination }:
      {
        combination = "f${combination}";
        description = "Find ${description}";
      }
    ) (builtins.attrValues neovimKeymapConfig.find);
    "Go To" = builtins.map (
      { description, combination }:
      {
        combination = "g${combination}";
        description = "Go to ${description}";
      }
    ) (builtins.attrValues neovimKeymapConfig.goTo);
    "Refactor" = builtins.map (
      { description, combination }:
      {
        combination = "r${combination}";
        description = "Refactor ${description}";
      }
    ) (builtins.attrValues neovimKeymapConfig.refactor);
    "Select" = builtins.map (
      { description, combination }:
      {
        combination = "s${combination}";
        description = "Select ${description}";
      }
    ) (builtins.attrValues neovimKeymapConfig.select);
    "Miscellaneous" = builtins.map (
      { description, combination }:
      {
        inherit description combination;
      }
    ) (builtins.attrValues neovimKeymapConfig.topLevel);
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
      inherit lib;
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
    echo '${builtins.toJSON keymapsAst}' > $out
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
