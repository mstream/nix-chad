{ config, nix-to-lua, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  mapping = import ./mapping.nix { inherit kms nix-to-lua; };
in
{
  programs.nixvim.plugins.cmp = {
    autoEnableSources = true;
    enable = true;
    settings = {
      inherit mapping;
      completions = {
        keyword_length = 1;
        keyword_pattern = ".*";
      };
      snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    };
  };
}
