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
      nixpkgs-firefox-darwin,
      nixvim,
      nur,
      ...
    }:
    chadLib: system: chadConfig:
    let
      specialArgs = {
        inherit
          chadLib
          home-manager
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
          home-manager.extraSpecialArgs = specialArgs;
        }
        ../../modules/darwin
      ];
    };
}
