{ osConfig, ... }:
let
  cfg = osConfig.chad;
in
{
  programs.git = {
    enable = true;
    settings = {
      aliases = { };
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
      user = {
        inherit (cfg.user) email name;
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
  };
}
