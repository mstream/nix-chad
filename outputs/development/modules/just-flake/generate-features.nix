{
  chadLib,
  groups,
  recipes,
  ...
}:
let
  validators = with chadLib.yants; rec {
    feature = {
      enable = bool;
      justfile = string;
    };
    hooks = struct "hooks" {
      after = list (eitherN (chadLib.core.attrNames groups.members));
      before = list (eitherN (chadLib.core.attrNames groups.members));
    };
    recipeSpec = struct "recipeSpec" {
      inherit hooks;
      comment = string;
      groups = list (eitherN (chadLib.core.attrNames groups.members));
      script = string;
    };
    recipeSpecToFeature = defun [
      recipeSpec
      feature
    ];
  };

  indent = chadLib.functions.compose [
    (chadLib.strings.splitString "\n")
    (chadLib.strings.concatStringsSep "\n  ")
    (s: "  ${s}")
  ];
  showGroups = chadLib.strings.concatMapStringsSep "\n" (
    chadLib.functions.compose [
      groups.mapTo.name
      (groupName: "[group('${groupName}')]")
    ]
  );
  showBeforeHooks = chadLib.strings.concatStringsSep " ";
  showAfterHooks =
    afterHooks:
    if chadLib.lists.isEmpty afterHooks then
      ""
    else
      "&& " + chadLib.strings.concatStringsSep " " afterHooks;
  showArguments = chadLib.strings.concatStringsSep " ";
  showHooks =
    {
      after ? [ ],
      before ? [ ],
    }:
    chadLib.concatStringsSep " " [
      (showBeforeHooks before)
      (showAfterHooks after)
    ];

  recipeSpecToFeature = recipeName: spec: {
    enable = true;
    justfile =
      let
        argumentsRep =
          if chadLib.core.hasAttr "arguments" spec then
            " ${showArguments spec.arguments}"
          else
            "";
        hooksRep =
          if chadLib.core.hasAttr "hooks" spec then
            " ${showHooks spec.hooks}"
          else
            "";

        commentLine = "# ${spec.comment}";
        groupsBlock = showGroups (
          if chadLib.core.hasAttr "groups" spec then spec.groups else [ ]
        );
        privateLine =
          if chadLib.core.hasAttr "isPrivate" spec && spec.isPrivate then
            "[private]"
          else
            "";
        recipeHeaderLine = "${recipeName}${argumentsRep}:${hooksRep}";
        recipeBashShebangLine = "#!/usr/bin/env bash";
        recipeBashOptionsLine = "set -eoux pipefail";
        recipeBodyLines = ''
          ${recipeBashShebangLine}
          ${recipeBashOptionsLine}
          ${spec.script}
        '';
      in
      ''
        ${commentLine}
        ${privateLine}
        ${groupsBlock}
        ${recipeHeaderLine}
        ${indent recipeBodyLines}
      '';
  };

  declarationsFeature =
    declarations:
    let
      showDeclarations = chadLib.attrsets.foldlAttrs (
        acc: name: value:
        "${acc}\n${name} := ${value}"
      ) "";

    in
    {
      enable = true;
      justfile = ''
        ${showDeclarations declarations}
      '';
    };
in
chadLib.functions.compose [
  (chadLib.attrsets.mapAttrs recipeSpecToFeature)
  (chadLib.attrsets.merge {
    _declarations = declarationsFeature {
      call_recipe = ''
        just_executable() + " --justfile=" + justfile()
      '';
      ci = ''
        env_var_or_default("CI", "false")
      '';
      conf_attr = ''
        "darwinConfigurations.macbook.aarch64-darwin.system"
      '';
      github_repo = ''
        "mstream/nix-chad"
      '';
      repo_root = ''
        justfile_directory()
      '';
    };
  })
]
