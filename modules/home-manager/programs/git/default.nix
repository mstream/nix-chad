{ username, ... }: {
  aliases = {
    br = "branch";
    ci = "commit";
    co = "checkout";
    st = "status";
  };
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
    push = { default = "simple"; };
  };
  ignores = [ ".direnv" ".DS_Store" "*~" "*.swp" ];
  userEmail = "maciej.laciak@gmail.com";
  userName = username;
}
