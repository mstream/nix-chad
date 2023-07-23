{ darwin
, easy-purescript-nix
, flake-utils
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
    ../modules/documentation/default.nix
    ../modules/environment/default.nix
    ../modules/fonts/default.nix
    ({ pkgs, ... }: (import ../modules/home-manager
      {
        inherit pkgs;
        easy-ps = import easy-purescript-nix { inherit pkgs; };
        version = home-manager-version;
      }
      config
    ))
    (import ../modules/homebrew/default.nix
      { inherit (config) manageHomebrew; }
    )
    ({ pkgs, ... }: (import ../modules/nix { inherit pkgs system; }))
    (import ../modules/nixpkgs { inherit nur; })
    (import ../modules/programs)
    (import ../modules/services)
    (import ../modules/system { inherit (config) fontSize; })
    (import ../modules/users { inherit (config) username; })
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
