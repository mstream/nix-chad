{ pkgs, ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;
    servers = {
      bashls.enable = true;
      cssls.enable = true;
      dhall_lsp_server.enable = true;
      dockerls.enable = true;
      html.enable = true;
      java_language_server.enable = true;
      jqls.enable = true;
      jsonls.enable = true;
      ltex.enable = true;
      lua_ls.enable = true;
      nixd = {
        autostart = true;
        enable = true;
      };
      purescriptls = {
        enable = true;
        package = pkgs.nodePackages.purescript-language-server;
      };
      sqls.enable = true;
      ts_ls.enable = true;
      yamlls.enable = true;
    };
  };
}
