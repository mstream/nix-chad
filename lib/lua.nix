{ lib, ... }:
let
  camelToSnakeCase = lib.strings.stringAsChars (
    c: if lib.strings.toUpper c == c then "_${lib.strings.toLower c}" else c
  );

  escapeString = lib.strings.stringAsChars (
    c: if c == "\\" then "\\\\" else c
  );

  indent = line: "    ${line}";

  bodyLines = lib.foldlAttrs (
    acc: key: val:
    let
      firstLine = "${camelToSnakeCase key} =";

      otherLines =
        if lib.core.isAttrs val then
          recordLines val
        else
          [ ''"${escapeString val}"'' ];
    in
    acc ++ [ firstLine ] ++ lib.core.map indent otherLines ++ [ "," ]
  ) [ ];

  recordLines =
    attrs: [ "{" ] ++ (lib.core.map indent (bodyLines attrs)) ++ [ "}" ];
in
{
  renderAttrs =
    attrs:
    let
      code = lib.strings.concatStringsSep "\n" (recordLines attrs);
    in
    ''
      ${code}
    '';
}
