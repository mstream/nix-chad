{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    settings = {
    };
    sources = {
      diagnostics = {
        deadnix.enable = true;
        statix.enable = true;
      };
      formatting.treefmt.enable = true;
    };
  };
}
