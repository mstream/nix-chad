/**
   Darwin related functions
*/
{
  /**
    Create activation scripts for Darwin system with a desired config applied.
  */
  makeSystem =
    {
      home-manager,
      nix-darwin,
      nix-rosetta-builder,
      nixvim,
      nur,
      ...
    }:
    chadLib: system: nixosVersion: chadConfig:
    let
      specialArgs = {
        inherit
          chadLib
          home-manager
          nix-rosetta-builder
          nixosVersion
          nixvim
          nur
          system
          ;
      };
    in
    nix-darwin.lib.darwinSystem {
      inherit specialArgs system;
      modules = [
        # FIXME I could make nixvim work as a hm module because of
        # an infiite recursion issue.
        # It feels like it should belong there so different users
        # could have different vim configurations.
        {
          chad = chadConfig;
          home-manager.extraSpecialArgs = specialArgs;
          nix-rosetta-builder = {
            cores = 4;
            diskSize = "32GiB";
            enable = true;
            memory = "16GiB";
            onDemand = true;
            onDemandLingerMinutes = 180;
          };
        }
        ../../modules/darwin
      ];
    };
}
