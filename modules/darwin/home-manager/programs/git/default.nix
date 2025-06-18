{ osConfig, ... }:
let
  cfg = osConfig.chad;
in
{
  programs.git = {
    aliases = { };
    enable = true;
    delta = {
      enable = true;
      options = {
        syntax-theme = "GitHub";
        line-numbers = true;
      };
    };
    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "vim";
        ignorecase = false;
      };
      init = {
        defaultBranch = "master";
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
    };
    ignores = [
      ".direnv"
      ".DS_Store"
      "*~"
      "*.swp"
    ];
    includes = builtins.map (
      {
        repositoryUrl,
        sshKeyPath,
        userEmail,
      }:
      {
        condition = "hasconfig:remote.*.url:${repositoryUrl}";
        contents = {
          core.sshCommand = "ssh -i ${sshKeyPath}";
          user.email = userEmail;
        };
      }
    ) cfg.git.alternativeGitIdentities;
    userEmail = "maciej.laciak@gmail.com";
    userName = cfg.user.name;
  };
}
