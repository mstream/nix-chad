chadLib:
let
  validators = with chadLib.yants; rec {
    arrayItemReference = defun [
      variableName
      int
      string
    ];

    arrayRef = function;

    catchErrorExec = defun [
      commands
      string
    ];

    command = defun [
      (struct "commandConf" {
        flags = option flags;
        parameters = option parameters;
        program = string;
      })
      string
    ];

    commands = list singleLineString;

    echoError = defun [
      singleLineString
      string
    ];

    flags = list string;

    options = defun [
      (struct "optionsConf" {
        flags = option flags;
        parameters = option parameters;
      })
      string
    ];

    parameters = attrs string;

    singleLineString = restrict "single line" (chadLib.functions.compose [
      chadLib.strings.stringToCharacters
      (chadLib.core.any (c: c == "\n"))
      chadLib.functions.negate
    ]) string;

    textRef = string;

    refs = attrs (either arrayRef textRef);

    variableName = restrict "valid Bash variable name" (
      chadLib.functions.compose
      [
        (chadLib.core.match "[a-zA-Z_][a-zA-Z_0-9]*")
        chadLib.core.isList
      ]
    ) singleLineString;

    variableReference = defun [
      variableName
      string
    ];
  };

  arrayVariableNames = {
    patternMatch = "BASH_REMATCH";
  };

  textVariableNames = {
    output = "cmd_out";
    returnCode = "cmd_ret";
  };

  /**
    Generate bash code which executes a sequence of commands and
    stores their standard output and return code in cmd_out and
    cmd_ret variables.

    # Example

    ```nix
    catchErrorExec ["foo" "bar" "baz"]
    =>
    "set +e;cmd_out=$(foo bar baz 2>&1);cmd_ret=$?;set -e"
    ```

    # Type

    ```
    catchErrorExec :: [String] -> String
    ```

    # Arguments

    commands
    : List of commands to be executed
  */
  catchErrorExec = validators.catchErrorExec (
    commands:
    let
      commandsRep = chadLib.strings.concatStringsSep "; " commands;
    in
    chadLib.strings.concatStringsSep "; " [
      "set +e"
      "${textVariableNames.output}=$(${commandsRep} 2>&1)"
      "${textVariableNames.returnCode}=$?"
      "set -e"
    ]
  );

  /**
    Generate bash code which matches a text against a pattern

    # Example

    ```nix
    matchPattern {pattern="a([[:lower:]])c?";text="ab";}
    =>
    "[p \"ab\" =~ a([[:lower:]])c? ]]"
    ```

    # Type

    ```
    echoError :: AttrSet -> String
    ```

    # Arguments

    config
    : Configuration including pattern and text
  */
  matchPattern = { pattern, text }: "[[ \"${text}\" =~ ${pattern} ]]";

  /**
    Generate bash code printing a message into standard error stream

    # Example

    ```nix
    echoError "foo bar"
    =>
    "echo \"foo bar\" >&2"
    ```

    # Type

    ```
    echoError :: String -> String
    ```

    # Arguments

    message
    : Message to be printed
  */
  echoError = message: "echo \"${message}\" >&2";

  /**
    Generate bash code representing command options

    # Example

    ```nix
    options {flags=["foo"];parameters={bar="baz";};}
    =>
    "--foo --bar baz"
    ```

    # Type

    ```
    options :: AttrSet -> String
    ```

    # Arguments

    config
    : Configuration including flags and parameters
  */
  options = validators.options (
    conf:
    let
      flags =
        if chadLib.attrsets.hasAttr "flags" conf then conf.flags else [ ];

      parameters =
        if chadLib.attrsets.hasAttr "parameters" conf then
          conf.parameters
        else
          { };

      flagsRep = chadLib.strings.concatMapStringsSep " " (
        name:
        if chadLib.core.stringLength name == 1 then "-${name}" else "--${name}"
      ) flags;

      parametersRep = chadLib.strings.concatStringsSep " " (
        chadLib.attrsets.mapAttrsToList (
          name: argument: "--${name} ${argument}"
        ) parameters
      );
    in
    "${flagsRep} ${parametersRep}"
  );

  /**
    Generate bash code representing program invocation command

    # Example

    ```nix
    command {flags=["foo"];parameters={bar="baz";};program="qux";}
    =>
    "qux --foo --bar baz"
    ```

    # Type

    ```
    options :: AttrSet -> String
    ```

    # Arguments

    config
    : Configuration including flags and parameters and program path
  */
  command = validators.command (
    conf:
    let
      optionsRep = options {
        flags =
          if chadLib.attrsets.hasAttr "flags" conf then conf.flags else [ ];
        parameters =
          if chadLib.attrsets.hasAttr "parameters" conf then
            conf.parameters
          else
            { };
      };
    in
    "${conf.program} ${optionsRep}"
  );

  variableReference = validators.variableReference (
    variableName: "$" + "{${variableName}}"
  );

  arrayItemReference = validators.arrayItemReference (
    variableName: index:
    let
      indexRep = chadLib.core.toString index;
    in
    "$" + "{${variableName}[${indexRep}]}"
  );

  arrayRefs = chadLib.core.mapAttrs (chadLib.functions.constant arrayItemReference) arrayVariableNames;

  textRefs = chadLib.core.mapAttrs (chadLib.functions.constant variableReference) textVariableNames;

  refs = validators.refs (chadLib.attrsets.merge textRefs arrayRefs);
in
{
  inherit
    catchErrorExec
    command
    echoError
    matchPattern
    options
    refs
    ;
}
