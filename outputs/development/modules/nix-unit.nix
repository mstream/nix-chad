{ inputs, ... }:
{
  imports = [
    inputs.nix-unit.modules.flake.default
  ];
  perSystem = _: {
    nix-unit = {
      inherit inputs;
      allowNetwork = false;
      enableSystemAgnostic = true;
    };
  };
}
