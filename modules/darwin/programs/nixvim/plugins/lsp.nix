{
  chadLib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  jumpLua =
    count:
    with chadLib.lua.ast;
    functionDefinition {
      arguments = [ ];
      body = [
        (functionInvocation {
          function = recordDereference {
            key = string "jump";
            record = recordDereference {
              key = string "diagnostic";
              record = identifier "vim";
            };
          };
          parameters = [
            (record {
              entries = {
                count = number count;
                float = boolean true;
              };
            })
          ];
        })
      ];
    };
in
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = [
      {
        action = chadLib.lua.render (jumpLua (-1));
        key = kms.categorized.jumpTo.suffixes.previousProblem;
      }
      {
        action = chadLib.lua.render (jumpLua 1);
        key = kms.categorized.jumpTo.suffixes.nextProblem;
      }
    ];
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
