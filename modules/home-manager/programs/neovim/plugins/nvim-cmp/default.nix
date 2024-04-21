{ pkgs, ... }: {
  config = builtins.readFile(./config.lua);
  plugin = pkgs.vimPlugins.nvim-cmp;
  type = "lua";
}
