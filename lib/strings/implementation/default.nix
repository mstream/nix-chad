chadLib:
let
  /**
      Convert camel-case string to kebab-case string

      # Example

      ```nix
      camelToKebabCase "fooBar"
      =>
      "foo-bar"
      ```

      # Type

      ```
      camelToKebabCase :: String -> String
      ```

      # Arguments

      input
      : Input string
  */
  camelToKebabCase = chadLib.strings.stringAsChars (
    char:
    if chadLib.strings.toUpper char == char then
      "-${chadLib.strings.toLower char}"
    else
      char
  );

  /**
      Convert camel-case string to snake-case string

      # Example

      ```nix
      camelToSnakeCase "fooBar"
      =>
      "foo_bar"
      ```

      # Type

      ```
      camelToSnakeCase :: String -> String
      ```

      # Arguments

      input
      : Input string
  */
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
