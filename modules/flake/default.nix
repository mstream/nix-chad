{ chadLib, ... }:
{
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
      standardFeatures = { };
      customFeatures = generateFeatures (
        import ./recipes.nix { inherit groups; }
      );
    in
    {
      config.just-flake.features = standardFeatures // customFeatures;
    };
}
