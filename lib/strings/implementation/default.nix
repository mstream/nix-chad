chadLib:
let
  camelToKebabCase = chadLib.strings.stringAsChars (
    char:
    if chadLib.strings.toUpper char == char then
      "-${chadLib.strings.toLower char}"
    else
      char
  );

  camelToSnakeCase = chadLib.strings.stringAsChars (
    char:
    if chadLib.strings.toUpper char == char then
      "_${chadLib.strings.toLower char}"
    else
      char
  );
in
{
  inherit camelToKebabCase camelToSnakeCase;
}
