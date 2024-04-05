{ pkgs, ... }: {
  config = builtins.readFile(./config.lua);
  plugin = pkgs.vimPlugins.vim-airline-themes;
  type = "lua";
}
