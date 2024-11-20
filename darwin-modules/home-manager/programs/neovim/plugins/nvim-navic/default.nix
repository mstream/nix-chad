{ pkgs, ... }:
{
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.nvim-navic;
  type = "lua";
}
