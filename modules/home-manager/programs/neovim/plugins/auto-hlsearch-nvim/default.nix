{ pkgs, ... }: {
  config = builtins.readFile(./config.lua);
  plugin = pkgs.vimPlugins.auto-hlsearch-nvim;
  type = "lua";
}
