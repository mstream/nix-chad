{
  groups,
  ...
}:
{
  comment = "List project's flake inputs.";
  groups = with groups.members; [
    generation
  ];
  script = ''
    nix flake metadata --json . | jq -r '.locks.nodes.root.inputs[]'
  '';
}
