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
      nixpkgs,
      nixvim,
      nur,
      purescript-overlay,
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
          nixpkgs
          nixvim
          nur
          purescript-overlay
          system
          ;
      };
    in
    nix-darwin.lib.darwinSystem {
      inherit specialArgs system;
      modules = [
        # FIXME I could make nixvim work as a hm module because of
        # an infinite recursion issue.
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
