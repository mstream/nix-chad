/**
   Darwin related functions
*/
{
  /**
    Create activation scripts for Darwin system with a desired config applied.
  */
  makeSystem =
    {
      darwin,
      home-manager,
      nix-to-lua,
      nixpkgs-firefox-darwin,
      nixvim,
      nur,
      ...
    }:
    lib: system: chadConfig:
    let
      specialArgs = {
        inherit
          home-manager
          lib
          nix-to-lua
          nixpkgs-firefox-darwin
          nixvim
          nur
          system
          ;
      };
    in
    darwin.lib.darwinSystem {
      inherit specialArgs system;
      modules = [
        # FIXME I could make nixvim work as a hm module because of
        # an infiite recursion issue.
        # It feels like it should belong there so different users
        # could have different vim configurations.
        {
          chad = chadConfig;
          # Do not override "lib" as Home Manager adds its own
          # extensions to the "lib" taken from darwin system's
          # "specialArgs".
          home-manager.extraSpecialArgs = builtins.removeAttrs specialArgs [
            "lib"
          ];
        }
        ./darwin-modules
      ];
    };
}
