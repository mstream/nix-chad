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
  environment.systemPackages = with pkgs; [ purs-tidy ];
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
        package = pkgs.purescript-language-server;
        rootMarkers = [
          "spago.lock"
        ];
        settings = {
          purescript = {
            autocompleteAddImport = true;
            autocompleteAllModules = true;
            autocompleteGrouped = true;
            addSpagoSources = true;
            buildOpenedFiles = true;
            # declarationTypeCodeLens = true;
            # exportsCodeLens = true;
            fastRebuild = true;
            formatter = "purs-tidy";
          };
        };
      };
      sqls.enable = true;
      ts_ls.enable = true;
      yamlls.enable = true;
    };
  };
}
