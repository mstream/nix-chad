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
{ defaultGpgKey, fontSize, manageHomebrew, username }:
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    home-manager.darwinModule
    ../modules/documentation/default.nix
    ../modules/environment/default.nix
    ../modules/fonts/default.nix
    ({ pkgs, ... }: (import ../modules/home-manager/default.nix {
      inherit defaultGpgKey fontSize pkgs username;
      easy-ps = import easy-purescript-nix { inherit pkgs; };
      version = home-manager-version;
    }))
    (import ../modules/homebrew/default.nix manageHomebrew)
    ({ pkgs, ... }:
      (import ../modules/nix/default.nix { inherit pkgs system; }))
    (_: import ../modules/nixpkgs/default.nix { inherit nur; })
    ../modules/programs/default.nix
    (_: import ../modules/services/default.nix { })
    (import ../modules/system/default.nix { inherit fontSize; })
    (_: import ../modules/users/default.nix { inherit username; })
    nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = manageHomebrew;
        enableRosetta = true;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-bundle" = homebrew-bundle;
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
        };
        user = username;
      };
    }
  ];
}
