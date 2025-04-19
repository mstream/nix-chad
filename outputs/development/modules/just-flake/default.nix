{ chadLib, inputs, ... }:
{
  imports = [
    inputs.just-flake.flakeModule
  ];
  perSystem =
    _:
    let
      groups = chadLib.enum.create {
        mappings = {
          name = {
            check = "check";
            generation = "generation";
            test = "test";
          };
        };
        memberNames = [
          "check"
          "generation"
          "test"
        ];
        name = "groups";
      };
      generateFeatures = import ./generate-features.nix {
        inherit chadLib groups;
      };
      nixBuildCommand = import ./nix-build-command.nix {
        inherit chadLib;
      };
      standardFeatures = { };
      customFeatures = generateFeatures (
        import ./recipes.nix { inherit chadLib groups nixBuildCommand; }
      );
    in
    {
      config.just-flake.features = standardFeatures // customFeatures;
    };
}
