{
  chadLib,
  inputs,
  nixosVersion,
  ...
}:
let
  makeChadOutputs =
    { config, system }:
    {
      apps.${system}.switch = inputs.flake-utils.lib.mkApp {
        drv = import ../packages/switch {
          inherit system;
          pkgs = import inputs.nixpkgs { inherit system; };
        };
      };

      darwinConfigurations.macbook.${system} =
        (import ../darwin.nix).makeSystem inputs chadLib system nixosVersion
          config;
    };

  supportedDarwinSystems = with inputs.flake-utils.lib.system; [
    aarch64-darwin
    x86_64-darwin
  ];
in
{
  flake = {
    lib.chad =
      config:
      chadLib.attrsets.generate supportedDarwinSystems (
        system:
        makeChadOutputs {
          inherit
            config
            system
            ;
        }
      );

    templates.default = {
      description = "A default template";
      path = ../templates/default;
    };
  };
}
