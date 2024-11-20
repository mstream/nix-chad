{ pkgs, ... }:
{
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.nvim-web-devicons;
  type = "lua";
}
