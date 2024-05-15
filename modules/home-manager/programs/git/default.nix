{ osConfig, ... }:
let cfg = osConfig.chad;
in {
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
      init = { defaultBranch = "master"; };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
    };
    ignores = [ ".direnv" ".DS_Store" "*~" "*.swp" ];
    userEmail = "maciej.laciak@gmail.com";
    userName = cfg.user.name;
  };
}
