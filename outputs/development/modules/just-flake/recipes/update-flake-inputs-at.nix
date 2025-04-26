{
  groups,
  ...
}:
{
  arguments = [ "repo_path" ];
  comment = "Update public flake inputs.";
  groups = with groups.members; [
    generation
  ];
  isPrivate = true;
  script = ''
    directory="{{repo_root}}{{repo_path}}"
    flake_template_path="''${directory}flake.template.nix" 
    flake_backup_path="''${directory}flake.backup.nix" 
    flake_path="''${directory}flake.nix"
    cp $flake_path $flake_backup_path
    cat $flake_template_path | envsubst --no-empty > $flake_path 
    nix flake lock $directory || cp $flake_backup_path $flake_path
    rm $flake_backup_path
  '';
}
