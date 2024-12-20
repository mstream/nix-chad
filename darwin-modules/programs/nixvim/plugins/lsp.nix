{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;
    servers = {
      dhall_lsp_server.enable = true;
      lua_ls.enable = true;
      nixd.enable = true;
      ts_ls.enable = true;
    };
  };
}
