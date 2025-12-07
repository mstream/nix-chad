chadLib:
let
  validators = with chadLib.yants; rec {
    args = list (either int string);
    key = defun [
      (struct "keyConf" {
        args = option args;
        name = string;
      })
      string
    ];
  };
  /**
      Generate a key with given name and arguments

      # Example

      ```nix
      key {name="foo";args=["bar" 123];}
      =>
      "foo \"bar\" 123"
      ```

      # Type

      ```
      key :: AttrSet -> String
      ```

      # Arguments

      config
      : Config containing name and arguments
  */
  key = validators.key (
    {
      args ? [ ],
      name,
    }:
    let
      argToString =
        arg:
        if chadLib.core.isString arg then
          "\"${arg}\""
        else
          "${chadLib.core.toString arg}";

      argsRep = chadLib.strings.concatMapStrings (
        arg: " ${argToString arg}"
      ) args;
    in
    "${name}${argsRep}"
  );
in
{
  inherit key;
}
