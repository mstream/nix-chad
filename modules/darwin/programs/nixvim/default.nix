{
  config = {
    programs.nixvim = {
      enable = true;
      enableMan = true;
      clipboard = {
        register = "unnamedplus";
      };
      luaLoader.enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  imports = [
    ./color-schemes
    ./globals.nix
    ./keymaps.nix
    ./options
    ./performance.nix
    ./plugins
  ];
}
