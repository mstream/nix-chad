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
      justFlakeDependencies = with pkgs; [
        envsubst
        nix
        yq
      ];
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = justFlakeDependencies;
        inputsFrom = [
          config.just-flake.outputs.devShell
        ] ++ localPackages;
        name = "nix-chad-dev";
      };
    };
}
