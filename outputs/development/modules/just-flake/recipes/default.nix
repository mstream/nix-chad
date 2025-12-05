{
  chadLib,
  groups,
  nixBuildCommand,
  recipes,
  ...
}:
let
  dependencies = {
    inherit chadLib groups nixBuildCommand;
    nixOsVersion = "25.11";
  };
in
{
  ${recipes.mapTo.name recipes.members.checkDebug} =
    import ./check-debug.nix dependencies;

  ${recipes.mapTo.name recipes.members.checkGeneration} =
    import ./check-generation.nix dependencies;

  ${recipes.mapTo.name recipes.members.generateDocumentation} =
    import ./generate-documentation.nix dependencies;

  ${recipes.mapTo.name recipes.members.generateWebsite} =
    import ./generate-website.nix dependencies;

  ${recipes.mapTo.name recipes.members.getCommitId} =
    import ./get-commit-id.nix dependencies;

  ${recipes.mapTo.name recipes.members.listFlakeInputs} =
    import ./list-flake-inputs.nix dependencies;

  ${recipes.mapTo.name recipes.members.runIntegrationTests} =
    import ./run-integration-tests.nix dependencies;

  ${recipes.mapTo.name recipes.members.runLints} =
    import ./run-lints.nix dependencies;

  ${recipes.mapTo.name recipes.members.runUnitTests} =
    import ./run-unit-tests.nix dependencies;

  ${recipes.mapTo.name recipes.members.updateFlakeInputs} =
    import ./update-flake-inputs.nix dependencies;

  ${recipes.mapTo.name recipes.members.updateGithubWorkflows} =
    import ./update-github-workflows.nix dependencies;

  ${recipes.mapTo.name recipes.members.applyTemplate} =
    import ./apply-template.nix dependencies;

  ${recipes.mapTo.name recipes.members.validateProject} =
    import ./validate-project.nix dependencies;
}
