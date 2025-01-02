{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings = {
      attach_to_untracked = true;
      auto_attach = true;
      signcolumn = true;
      watch_gitdir = {
        enable = true;
        follow_files = true;
      };
    };
  };
}
