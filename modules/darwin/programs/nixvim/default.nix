{ nixpkgs, ... }:
{
  config = {
    programs.nixvim = {
      enable = true;
      enableMan = true;
      clipboard = {
        register = "unnamedplus";
      };
      luaLoader.enable = true;
      nixpkgs = {
        config = {
          allowBroken = false;
          allowUnfree = true;
        };
        source = nixpkgs;
      };
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
