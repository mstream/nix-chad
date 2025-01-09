{ chadLib, ... }:
{
  perSystem =
    {
      config,
      pkgs,
      self',
      ...
    }:
    let
      localPackages = chadLib.core.attrValues self'.packages;
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = localPackages;
        inputsFrom = [
          config.just-flake.outputs.devShell
        ] ++ localPackages;
        name = "nix-chad-dev";
      };
    };
}
