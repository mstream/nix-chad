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
      yants,
      ...
    }:
    system: chadConfig:
    let
      specialArgs = {
        inherit
          home-manager
          nix-to-lua
          nixpkgs-firefox-darwin
          nixvim
          nur
          system
          yants
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
          home-manager.extraSpecialArgs = specialArgs;
        }
        ../darwin-modules
      ];
    };
}
