{
  chadLib,
  groups,
  ...
}:
{
  comment = "Check if flake debug is disabled.";
  groups = with groups.members; [
    check
  ];
  script = with chadLib.bash; ''
    if [ $(nix flake show --json | jq .'debug' | wc -l) -ne 1 ]; then
      ${echoError "Flake debug mode seems to be left enabled."}
      exit 1
    else
      echo "Flake debug mode is disabled"
    fi
  '';
}
