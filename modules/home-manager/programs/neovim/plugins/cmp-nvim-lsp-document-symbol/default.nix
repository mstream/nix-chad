{ pkgs, ... }:
{
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.cmp-nvim-lsp-document-symbol;
  type = "lua";
}
