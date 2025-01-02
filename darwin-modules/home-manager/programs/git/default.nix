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
        repositoryPath,
        sshKeyPath,
        userEmail,
      }:
      {
        condition = "gitdir:${repositoryPath}";
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
