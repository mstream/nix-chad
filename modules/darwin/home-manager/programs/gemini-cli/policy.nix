{ allowedCommandPrefixes, chadLib, ... }:
let
  ruleText = prefix: ''
    [[rule]]
    toolName="run_shell_command"
    commandPrefix="${prefix}"
    decision="allow"
    priority=10
  '';
in
chadLib.strings.concatMapStringsSep "\n" ruleText allowedCommandPrefixes
