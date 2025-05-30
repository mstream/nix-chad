{
  chadLib,
  groups,
  ...
}:
let
  validators = with chadLib.yants; rec {
    feature = struct "feature" {
      enable = bool;
      justfile = string;
    };
    hooks = struct "hooks" {
      after = option (list string);
      before = option (list string);
    };
    recipeSpec = struct "recipeSpec" {
      arguments = option (list string);
      comment = string;
      hooks = option hooks;
      isPrivate = option bool;
      groups = option (list groups.enum);
      script = string;
    };
    recipeSpecToFeature = defun [
      string
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

  recipeSpecToFeature = validators.recipeSpecToFeature (
    recipeName: spec: {
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
    }
  );

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
