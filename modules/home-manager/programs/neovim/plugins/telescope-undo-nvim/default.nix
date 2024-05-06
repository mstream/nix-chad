{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.telescope-undo-nvim;
  type = "lua";
}
