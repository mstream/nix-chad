/**
   Darwin related functions
*/
{
  /**
    Create activation scripts for Darwin system with a desired config applied.

    # Inputs

    `flakeInputs`

    : flake inputs

    `system`

    : host system

    `chadConfig`

    : nix-chad configuration
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
    system: chadConfig:
    darwin.lib.darwinSystem {
      inherit system;
      modules = [
        # FIXME I could make nixvim work as a hm module because of 
        # an infiite recursion issue. 
        # It feels like it should belong there so different users
        # could have different vim configurations.
        nixvim.nixDarwinModules.nixvim
        home-manager.darwinModules.home-manager
        { chad = chadConfig; }
        ../darwin-modules
      ];
      specialArgs = {
        inherit
          nixpkgs-firefox-darwin
          nur
          system
          ;
      };
    };
}
