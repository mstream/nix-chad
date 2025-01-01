{ chadLib, groups, ... }:
let
  indent = chadLib.function.compose [
    (chadLib.strings.splitString "\n")
    (chadLib.strings.concatStringsSep "\n  ")
    (s: "  ${s}")
  ];
  showGroups = chadLib.strings.concatMapStringsSep "\n" (
    chadLib.function.compose [
      groups.mapTo.name
      (groupName: "[group('${groupName}')]")
    ]
  );
  showBeforeHooks =
    beforeHooks:
    if beforeHooks == null then
      ""
    else
      chadLib.strings.concatStringsSep " " beforeHooks;
  showAfterHooks =
    afterHooks:
    if afterHooks == null then
      ""
    else
      "&& " + chadLib.strings.concatStringsSep " " afterHooks;
  showHooks =
    {
      after ? { },
      before ? { },
    }:
    chadLib.concatStringsSep " " [
      (showBeforeHooks before)
      (showAfterHooks after)
    ];

  recipeSpecToFeature = recipeName: spec: {
    enable = true;
    justfile =
      let
        declarationLines =
          if chadLib.hasAttr "declarations" spec then spec.declarations else "";
        commentLine = "# ${spec.comment}";
        groupsLine = showGroups spec.groups;
        recipeHeaderLine =
          "${recipeName}:"
          + (
            if chadLib.core.hasAttr "hooks" spec then
              " ${showHooks spec.hooks}"
            else
              ""
          );
        recipeBashShebangLine = "#!/usr/bin/env bash";
        recipeBashOptionsLine = "set -eoux pipefail";
        recipeBodyLines = ''
          ${recipeBashShebangLine}
          ${recipeBashOptionsLine}
          ${spec.script}
        '';
      in
      ''
        ${declarationLines}
        ${commentLine}
        ${groupsLine}
        ${recipeHeaderLine}
        ${indent recipeBodyLines}
      '';
  };

in
chadLib.attrsets.mapAttrs recipeSpecToFeature
