{ chadLib, ... }:
installables:
let
  command = chadLib.strings.concatStringsSep " " [
    "build"
    "--print-build-logs"
    "--show-trace"
    installables
  ];
in
chadLib.nixCli.runCommand {
  inherit command;
  showFullLogsOnError = true;
}
