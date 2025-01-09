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

    commands = list singleLineString;

    echoError = defun [
      singleLineString
      string
    ];

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

  matchPattern = { pattern, text }: "[[ \"${text}\" =~ ${pattern} ]]";

  echoError = message: "echo \"${message}\" >&2";

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
    echoError
    matchPattern
    refs
    ;
}
