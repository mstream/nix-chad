{
  imports = [
    ./color-schemes.nix
    ./globals.nix
    ./keymaps.nix
    ./options.nix
    ./plugins
  ];

  config = {
    programs.nixvim = {
      enable = true;
      enableMan = true;
      clipboard = {
        register = "unnamedplus";
      };
      luaLoader.enable = true;
      #performance = {
      #  byteCompuleLua.enable = true;
      #  combinePlugins = true;
      #};
      viAlias = true;
      vimAlias = true;
    };
  };
}
