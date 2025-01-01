{ core, nixpkgsLib, ... }:
let
  camelToSnakeCase = nixpkgsLib.strings.stringAsChars (
    c:
    if nixpkgsLib.strings.toUpper c == c then
      "_${nixpkgsLib.strings.toLower c}"
    else
      c
  );

  escapeString = nixpkgsLib.strings.stringAsChars (
    c: if c == "\\" then "\\\\" else c
  );

  indent = line: "    ${line}";

  bodyLines = nixpkgsLib.foldlAttrs (
    acc: key: val:
    let
      firstLine = "${camelToSnakeCase key} =";

      otherLines =
        if core.isAttrs val then
          recordLines val
        else
          [ ''"${escapeString val}"'' ];
    in
    acc ++ [ firstLine ] ++ core.map indent otherLines ++ [ "," ]
  ) [ ];

  recordLines =
    attrs: [ "{" ] ++ (core.map indent (bodyLines attrs)) ++ [ "}" ];
in
{
  renderAttrs =
    attrs:
    let
      code = nixpkgsLib.strings.concatStringsSep "\n" (recordLines attrs);
    in
    ''
      ${code}
    '';
}
