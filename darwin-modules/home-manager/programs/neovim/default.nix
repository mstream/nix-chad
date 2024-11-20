{
  imports = [
    ./color-scheme.nix
    ./options.nix
  ];

  config = {
    programs.nixvim = {
      defaultEditor = true;
      enable = true;
      enableMan = true;
      clipboard = {
        register = "unnamedplus";
      };
      luaLoader.enable = true;
      opts = { };
      performance = {
        byteCompuleLua.enable = true;
        combinePlugins = true;
      };
      viAlias = true;
      vimAlias = true;
    };
  };
}
