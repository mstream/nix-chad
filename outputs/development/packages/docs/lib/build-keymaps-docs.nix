{
  chadLib,
  pkgs,
  validators,
  ...
}:
{ chadEvaluatedModules }:
let
  localValidators = with chadLib.yants; {
    neovimCategorizedKeymaps = defun [
      validators.neovimCategoryMappings
      validators.categorizedKeymaps
    ];
    neovimUncategorizedKeymaps = defun [
      validators.neovimOtherMappings
      validators.uncategorizedKeymaps
    ];
    zellijModalKeymaps = defun [
      validators.zellijModalMappings
      validators.categorizedKeymaps
    ];
    zellijSharedKeymaps = defun [
      validators.zellijSharedMappings
      validators.uncategorizedKeymaps
    ];
  };

  neovimKeymapConfig =
    chadEvaluatedModules.config.chad.editor.keyMappings;
  neovimKeymapOptions =
    chadEvaluatedModules.options.chad.editor.keyMappings;

  zellijKeymapConfig =
    chadEvaluatedModules.config.chad.terminal.keyMappings;
  zellijKeymapOptions =
    chadEvaluatedModules.options.chad.terminal.keyMappings;

  neovimCategorizedKeymaps = localValidators.neovimCategorizedKeymaps (
    chadLib.attrsets.mapAttrs' (
      categoryName: prefixEntry:
      let
        category = neovimKeymapOptions.categorized.${categoryName};
      in
      {
        name = category.prefix.description;
        value = chadLib.attrsets.mapAttrsToList (
          sequenceName: sequence:
          let
            sequenceOption = category.suffixes.${sequenceName};
          in
          {
            inherit sequence;
            inherit (sequenceOption) description;
          }
        ) prefixEntry.suffixes;
      }
    )
  );

  neovimUncategorizedKeymaps =
    localValidators.neovimUncategorizedKeymaps
      (
        chadLib.attrsets.mapAttrsToList (
          sequenceName: sequence:
          let
            sequenceOption = neovimKeymapOptions.uncategorized.${sequenceName};
          in
          {
            inherit sequence;
            inherit (sequenceOption) description;
          }
        )
      );

  zellijModalKeymaps = localValidators.zellijModalKeymaps (
    chadLib.attrsets.mapAttrs' (
      modeName: modalGroupEntry:
      let
        mode = zellijKeymapOptions.modal.${modeName};
      in
      {
        name = mode.description.description;
        value = chadLib.attrsets.mapAttrsToList (
          sequenceName: sequence:
          let
            sequenceOption = mode.entries.${sequenceName};
          in
          {
            inherit sequence;
            inherit (sequenceOption) description;
          }
        ) modalGroupEntry.entries;
      }
    )
  );

  zellijSharedKeymaps = localValidators.zellijSharedKeymaps (
    chadLib.attrsets.mapAttrsToList (
      sequenceName: sequence:
      let
        sequenceOption = zellijKeymapOptions.shared.${sequenceName};
      in
      {
        inherit sequence;
        inherit (sequenceOption) description;
      }
    )
  );

  neovimKeymaps = {
    categorized = neovimCategorizedKeymaps neovimKeymapConfig.categorized;
    uncategorized = neovimUncategorizedKeymaps neovimKeymapConfig.uncategorized;
  };

  zellijKeymaps = {
    categorized = zellijModalKeymaps zellijKeymapConfig.modal;
    uncategorized = zellijSharedKeymaps zellijKeymapConfig.shared;
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

  alacrittyAst =
    [ (programHeaderAst "Terminal Workspace (Zellij)") ]
    ++ (import ./zellij-keymaps-ast.nix {
      inherit chadLib validators;
      keymaps = zellijKeymaps;
    });

  neovimAst =
    [ (programHeaderAst "Editor (NeoVim)") ]
    ++ (import ./neovim-keymaps-ast.nix {
      inherit chadLib validators;
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
