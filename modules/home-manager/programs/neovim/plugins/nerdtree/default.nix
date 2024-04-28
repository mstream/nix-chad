{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.nerdtree;
  type = "lua";
}
