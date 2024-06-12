{ pkgs, ... }:
with pkgs.lib;
let
  camelToSnakeCase = strings.stringAsChars (
    c: if strings.toUpper c == c then "_${strings.toLower c}" else c
  );

  escapeString = strings.stringAsChars (c: if c == "\\" then "\\\\" else c);

  indent = line: "    ${line}";

  bodyLines = foldlAttrs (
    acc: key: val:
    let
      firstLine = "${camelToSnakeCase key} =";

      otherLines = if builtins.isAttrs val then recordLines val else [ ''"${escapeString val}"'' ];
    in
    acc ++ [ firstLine ] ++ builtins.map indent otherLines ++ [ "," ]
  ) [ ];

  recordLines = attrs: [ "{" ] ++ (builtins.map indent (bodyLines attrs)) ++ [ "}" ];
in
{
  renderAttrs =
    attrs:
    let
      code = strings.concatStringsSep "\n" (recordLines attrs);
    in
    ''
      ${code}
    '';
}
