{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.lsp-format-nvim;
  type = "lua";
}
