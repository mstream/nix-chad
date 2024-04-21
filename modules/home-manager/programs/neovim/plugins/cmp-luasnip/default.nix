{ pkgs, ... }: {
  config = builtins.readFile(./config.lua);
  plugin = pkgs.vimPlugins.cmp_luasnip;
  type = "lua";
}
