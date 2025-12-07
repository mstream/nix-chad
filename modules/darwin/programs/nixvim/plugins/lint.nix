{
  chadLib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;
  userName = "${cfg.user.name}";
  commitLintConfigHomePath = "Library/Application Support/commitlint/.commitlintrc.yml";
  valeConfigHomePath = "Library/Application Support/vale/.vale.ini";
in
{
  home-manager.users."${userName}".home.file = {
    "${commitLintConfigHomePath}" = {
      recursive = true;
      text = ''
        rules: {}
      '';
    };
    "${valeConfigHomePath}" = {
      recursive = true;
      text = ''
        MinAlertLevel = suggestion
        [formats]
        [*]
      '';
    };
  };
  programs.nixvim.plugins.lint = {
    autoCmd = {
      event = [
        "BufEnter"
        "BufWritePost"
      ];
    };
    enable = true;
    customLinters = { };
    linters = {
      commitlint = {
        args = [
          "--config"
          commitLintConfigHomePath
          "--strict"
        ];
        cmd = chadLib.meta.getExe pkgs.commitlint;
        stdin = true;
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
