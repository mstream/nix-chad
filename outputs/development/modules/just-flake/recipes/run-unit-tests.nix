{
  chadLib,
  groups,
  ...
}:
{
  comment = "run tests based on evaluating nix expressions.";
  groups = with groups.members; [
    test
  ];
  script = chadLib.nixCli.runCommand {
    command = "flake check --all-systems --show-trace";
    showFullLogsOnError = true;
  };
}
