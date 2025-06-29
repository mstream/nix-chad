{ chadLib, ... }:
with chadLib.yants;
rec {
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
}
