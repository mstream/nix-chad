{ config, chadLib, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  postHookLuaSnippet = chadLib.lua.render (
    with chadLib.lua.ast;
    functionDefinition {
      arguments = [ "info" ];
      body = [
        (functionInvocation {
          function = recordDereference {
            key = string "feedkeys";
            record = recordDereference {
              key = string "fn";
              record = identifier "vim";
            };
          };
          parameters = [ (string "zz") ];
        })
      ];
    }
  );
in
{
  programs.nixvim.plugins.neoscroll = {
    enable = true;
    settings = {
      cursor_scrolls_alone = true;
      easing_function = "quadratic";
      hide_cursor = true;
      mappings = with kms.uncategorized; [
        scrollDown
        scrollDownFullPage
        scrollUp
        scrollUpFullPage
      ];
      performance_mode = false;
      post_hook = postHookLuaSnippet;
      respect_scrolloff = false;
      stop_eof = true;
    };
  };
}
