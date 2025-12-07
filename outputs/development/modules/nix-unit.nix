{ inputs, ... }:
{
  imports = [
    inputs.nix-unit.modules.flake.default
  ];
  perSystem = _: {
    nix-unit = {
      inherit inputs;
      # TODO: restore once
      # https://github.com/nix-community/nix-unit/issues/270
      # is fixed
      # allowNetwork = false;
      allowNetwork = true;
      enableSystemAgnostic = true;
    };
  };
}
