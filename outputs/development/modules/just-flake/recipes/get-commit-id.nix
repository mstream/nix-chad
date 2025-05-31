{ groups, ... }:
{
  arguments = [
    "repo"
    "branch"
  ];
  comment = "Gets commit ID by reference.";
  groups = with groups.members; [
    utils
  ];
  isPrivate = false;
  script = ''
    git ls-remote "https://github.com/{{repo}}.git" | grep refs/heads/{{branch}}$ | cut -f 1
  '';
}
