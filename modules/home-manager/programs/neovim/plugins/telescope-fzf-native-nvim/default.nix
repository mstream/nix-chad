{ pkgs, ... }: {
  config = builtins.readFile(./config.lua);
  plugin = pkgs.vimPlugins.telescope-fzf-native-nvim;
  type = "lua";
}
