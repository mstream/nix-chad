{ pkgs, ... }:
{
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.cmp-omni;
  type = "lua";
}
