{
  chadLib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;
  userName = "${cfg.user.name}";
  valeConfigHomePath = "Library/Application Support/vale/.vale.ini";
in
{
  home-manager.users."${userName}".home.file."${valeConfigHomePath}" = {
    recursive = true;
    text = ''
      MinAlertLevel = suggestion
      [formats]
      [*]
    '';
  };
  programs.nixvim.plugins.lint = {
    enable = true;
    customLinters = { };
    linters = {
      commitlint = {
        cmd = chadLib.meta.getExe pkgs.commitlint;
      };
      statix = {
        cmd = chadLib.meta.getExe pkgs.statix;
      };
      vale = {
        cmd = chadLib.meta.getExe pkgs.vale;
      };
    };
    lintersByFt = {
      gitcommit = [
        "commitlint"
        "vale"
      ];
      nix = [
        "statix"
        "vale"
      ];
    };
  };
}
