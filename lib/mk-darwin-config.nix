{ darwin, homebrew-bundle, homebrew-cask, homebrew-core, home-manager
, home-manager-version, nix-homebrew, nur, ... }:
system: config:
let
  defaultConfig = {
    browserBookmarks = [ ];
    defaultGpgKey = null;
    extraCasks = [ ];
    extraPackages = [ ];
    fontSize = 12;
    homeDirectories = [ ];
    manageHomebrew = false;
    zshInitExtra = "";
  };
  configWithDefaults = defaultConfig // config;
in darwin.lib.darwinSystem {
  inherit system;
  modules = [
    home-manager.darwinModule
    ../modules/default.nix
    ({ pkgs, ... }:
      (import ../modules/home-manager {
        inherit pkgs;
        version = home-manager-version;
      } configWithDefaults))
    (import ../modules/homebrew/default.nix configWithDefaults)
    ({ pkgs, ... }: (import ../modules/nix { inherit pkgs system; }))
    (import ../modules/nixpkgs { inherit nur; })
    (import ../modules/programs)
    (import ../modules/system configWithDefaults)
    (import ../modules/users configWithDefaults)
    nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = configWithDefaults.manageHomebrew;
        enableRosetta = true;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-bundle" = homebrew-bundle;
          "homebrew/homebrew-cask" = homebrew-cask;
          "homebrew/homebrew-core" = homebrew-core;
        };
        user = configWithDefaults.username;
      };
    }
  ];
}
