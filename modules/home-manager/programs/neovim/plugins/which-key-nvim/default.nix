{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.which-key-nvim;
  type = "lua";
}
