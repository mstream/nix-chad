chadLib:
let
  runWithoutShowingFullLogsOnError = command: "nix ${command}";

  runWithShowingFullLogsOnError =
    command: with chadLib.bash; ''
      ${catchErrorExec [ "nix ${command}" ]}
      if [ ${refs.returnCode} -ne 0 ]; then
        if ${
          matchPattern {
            #TODO: create DSL for regular expressions
            pattern = "For[[:space:]]full[[:space:]]logs,[[:space:]]run[[:space:]]\\'([^\\']+)\\'.";
            text = refs.output;
          }
        }; then
          ${echoError "Full Nix logs:"}
          ${refs.patternMatch 1} >&2
        else
          ${echoError "Nix logs:"}
          ${echoError refs.output}
        fi
        exit ${refs.returnCode}
      fi
    '';

  runCommand =
    {
      command,
      showFullLogsOnError ? false,
    }:
    let
      run =
        if showFullLogsOnError then
          runWithShowingFullLogsOnError
        else
          runWithoutShowingFullLogsOnError;
    in
    run command;
in
{
  inherit runCommand;
}
