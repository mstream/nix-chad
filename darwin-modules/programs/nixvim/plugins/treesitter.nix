{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    nixGrammars = true;
    nixvimInjections = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
