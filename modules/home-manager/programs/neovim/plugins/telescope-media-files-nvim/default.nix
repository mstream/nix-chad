{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.telescope-media-files-nvim;
  type = "lua";
}
