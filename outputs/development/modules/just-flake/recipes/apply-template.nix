{
  groups,
  ...
}:
{
  arguments = [
    "repo_dir"
    "file_base_name"
    "file_extension"
    "validation_command"
  ];
  comment = "Update repo file based on its template.";
  groups = with groups.members; [
    generation
  ];
  isPrivate = true;
  script = ''
    template_path="{{repo_root}}/templates/{{repo_dir}}/{{file_base_name}}.template.{{file_extension}}" 
    output_dir="{{repo_root}}/{{repo_dir}}"
    backup_path="''${output_dir}/{{file_base_name}}.backup.{{file_extension}}" 
    output_path="''${output_dir}/{{file_base_name}}.{{file_extension}}" 
    cp ''${output_path} ''${backup_path}
    cat $template_path | envsubst --no-empty > ''${output_path}
    {{validation_command}} ''${output_path} || cp ''${backup_path} ''${output_path}
    rm ''${backup_path}
  '';
}
