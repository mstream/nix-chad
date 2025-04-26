{
  groups,
  nixBuildCommand,
  ...
}:
{
  comment = "Run all linters.";
  groups = with groups.members; [
    check
  ];
  script = ''
    ${nixBuildCommand ".#lint-all"}
  '';
}
