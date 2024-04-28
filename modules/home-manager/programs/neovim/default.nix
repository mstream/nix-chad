{ pkgs, ... }: {
  coc.enable = false;
  defaultEditor = true;
  enable = true;
  extraLuaConfig = builtins.readFile (./extra.lua);
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  plugins = import ./plugins { inherit pkgs; };
}
