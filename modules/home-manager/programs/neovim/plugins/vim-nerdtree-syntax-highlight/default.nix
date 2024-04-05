{ pkgs, ... }: {
  config = builtins.readFile(./config.lua);
  plugin = pkgs.vimPlugins.vim-nerdtree-syntax-highlight;
  type = "lua";
}
