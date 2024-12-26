{
  programs.nixvim.plugins.treesitter-textobjects = {
    enable = true;
    select = {
      enable = true;
      lookahead = true;
      keymaps = {
        "ac" = "@class.outer";
        "af" = "@function.outer";
        "ic" = "@class.inner";
        "if" = "@function.inner";
      };
    };
  };
}
