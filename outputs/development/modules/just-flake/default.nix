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
      recipes = chadLib.enum.create {
        mappings = {
          name = {
            applyTemplate = "apply-template";
            checkDebug = "check-debug";
            checkGeneration = "check-generation";
            generateDocumentation = "generate-documentation";
            generateWebsite = "generate-website";
            getCommitId = "get-commit-id";
            listFlakeInputs = "list-flake-inputs";
            runIntegrationTests = "run-integration-tests";
            runLints = "run-lints";
            runUnitTests = "run-unit-tests";
            updateFlakeInputs = "update-flake-inputs";
            updateGithubWorkflows = "update-github-workflows";
            validateProject = "validate-project";
          };
        };
        memberNames = [
          "applyTemplate"
          "checkDebug"
          "checkGeneration"
          "generateDocumentation"
          "generateWebsite"
          "getCommitId"
          "listFlakeInputs"
          "runIntegrationTests"
          "runLints"
          "runUnitTests"
          "updateFlakeInputs"
          "updateGithubWorkflows"
          "validateProject"
        ];
        name = "recipes";
      };
      generateFeatures = import ./generate-features.nix {
        inherit chadLib groups recipes;
      };
      nixBuildCommand = import ./nix-build-command.nix {
        inherit chadLib;
      };
      standardFeatures = { };
      customFeatures = generateFeatures (
        import ./recipes {
          inherit
            chadLib
            groups
            nixBuildCommand
            recipes
            ;
        }
      );
    in
    {
      config.just-flake.features = standardFeatures // customFeatures;
    };
}
