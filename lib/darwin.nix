/**
   Darwin related functions
*/
{
  /**
    Create activation scripts for Darwin system with a desired config applied.

    # Inputs

    `flakeInputs`

    : flake inputs containing darwin, home-manager and nur

    `system`

    : host system

    `chadConfig`

    : nix-chad configuration
  */
  makeSystem =
    {
      darwin,
      home-manager,
      nur,
      ...
    }:
    system: chadConfig:
    darwin.lib.darwinSystem {
      inherit system;
      modules = [
        { chad = chadConfig; }
        home-manager.darwinModules.home-manager
        ../modules/default.nix
      ];
      specialArgs = {
        inherit nur system;
      };
    };
}
