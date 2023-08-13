{ darwin
, easy-purescript-nix
, homebrew-bundle
, homebrew-cask
, homebrew-core
, home-manager
, home-manager-version
, nix-homebrew
, nur
, ...
}:
system:
config:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    home-manager.darwinModule
    ../modules/default.nix
    ({ pkgs, ... }: (import ../modules/home-manager
      {
        inherit pkgs;
        easy-ps = import easy-purescript-nix { inherit pkgs; };
        version = home-manager-version;
      }
      config
    ))
    (import ../modules/homebrew/default.nix config)
    ({ pkgs, ... }: (import ../modules/nix { inherit pkgs system; }))
    (import ../modules/nixpkgs { inherit nur; })
    (import ../modules/programs)
    (import ../modules/system config)
    (import ../modules/users config)
    nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = config.manageHomebrew;
        enableRosetta = true;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-bundle" = homebrew-bundle;
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
        };
        user = config.username;
      };
    }
  ];
}
