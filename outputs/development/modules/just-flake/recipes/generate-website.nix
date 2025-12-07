{
  groups,
  nixBuildCommand,
  ...
}:
{
  comment = "Generate website based on the source code.";
  groups = with groups.members; [
    generation
  ];
  script = ''
    ${nixBuildCommand ".#website"}
  '';
}
