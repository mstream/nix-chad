{
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
in
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      diagnostic = {
        ${kms.categorized.goTo.suffixes.nextProblem} = "goto_next";
        ${kms.categorized.goTo.suffixes.previousProblem} = "goto_prev";
      };
    };
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
        rootMarkers = [
          "spago.lock"
        ];
        settings = {
          purescript = {
            addSpagoSources = true;
          };
        };
      };
      sqls.enable = true;
      ts_ls.enable = true;
      yamlls.enable = true;
    };
  };
}
