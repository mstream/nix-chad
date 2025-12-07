{
  groups,
  nixBuildCommand,
  ...
}:
{
  comment = "Generate documentation based on the source code.";
  groups = with groups.members; [
    generation
  ];
  script = ''
    ${nixBuildCommand ".#docs"}
    rm -f -r docs 
    mkdir docs
    cp -r result/* docs/
    chmod -R +w docs/*
  '';
}
