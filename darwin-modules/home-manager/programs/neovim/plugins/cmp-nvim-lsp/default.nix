{ pkgs, ... }:
{
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.cmp-nvim-lsp;
  type = "lua";
}
