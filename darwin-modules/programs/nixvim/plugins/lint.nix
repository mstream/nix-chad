{
  config,
  lib,
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
    linters = {
      commitlint = {
        cmd = lib.getExe pkgs.commitlint;
      };
      statix = {
        cmd = lib.getExe pkgs.statix;
      };
      vale = {
        cmd = lib.getExe pkgs.vale;
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
