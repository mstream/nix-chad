{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.nerdtree-git-plugin;
  type = "lua";
}
