{ pkgs, ... }:
{
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.luasnip;
  type = "lua";
}
