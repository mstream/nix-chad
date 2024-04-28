{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.efmls-configs-nvim;
  type = "lua";
}
