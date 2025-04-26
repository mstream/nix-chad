{
  chadLib,
  groups,
  ...
}:
{
  comment = "Check if generation has run since last source changes.";
  groups = with groups.members; [
    check
    generation
  ];
  script = with chadLib.bash; ''
    if [[ $(git diff HEAD --stat) != "" ]]; then
      ${echoError "Changes to git working directory after detected:"}
      ${echoError "vvv"}
      git status >&2
      git diff HEAD >&2
      ${echoError "^^^"}
      ${echoError "aborting"}
      exit 1
    else
      echo "Git branch is clean."
    fi
  '';
}
