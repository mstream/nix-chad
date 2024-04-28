{ pkgs, ... }: {
  config = builtins.readFile (./config.lua);
  plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  type = "lua";
}
