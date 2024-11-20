{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
    };
  };
}
