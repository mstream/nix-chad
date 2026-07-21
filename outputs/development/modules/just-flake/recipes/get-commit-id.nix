{ groups, ... }:
{
  arguments = [
    "repo"
    "branch_or_tag"
  ];
  comment = "Gets commit ID by reference.";
  groups = with groups.members; [
    utils
  ];
  isPrivate = false;
  script = ''
    git ls-remote "https://github.com/{{repo}}.git" | grep -e 'refs/heads/{{branch_or_tag}}$' -e 'refs/tags/{{branch_or_tag}}$' | cut -f 1
  '';
}
