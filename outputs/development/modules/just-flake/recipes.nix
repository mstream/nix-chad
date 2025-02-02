{ chadLib, groups, ... }:
let
  nixBuildCommand =
    installables:
    let
      command = chadLib.strings.concatStringsSep " " [
        "build"
        "--print-build-logs"
        "--show-trace"
        installables
      ];
    in
    chadLib.nixCli.runCommand {
      inherit command;
      showFullLogsOnError = true;
    };
in
{
  check-debug = {
    comment = "Check if flake debug is disabled.";
    groups = with groups.members; [
      check
    ];
    script = with chadLib.bash; ''
      if [ $(nix flake show --json | jq .'debug' | wc -l) -ne 1 ]; then
        ${echoError "Flake debug mode seems to be left enabled."}
        exit 1
      else
        echo "Flake debug mode is disabled"
      fi
    '';
  };

  check-generation = {
    comment = "Check if generation has run since last source changes.";
    groups = with groups.members; [
      check
      generation
    ];
    script = with chadLib.bash; ''
      if [[ $(git diff HEAD --stat) != "" ]]; then
        ${echoError "Changes to git working directory after detected:"}
        ${echoError "vvv"}
        git status >&2
        git diff HEAD >&2
        ${echoError "^^^"}
        ${echoError "aborting"}
        exit 1
      else
        echo "Git branch is clean."
      fi
    '';
  };

  generate-documentation = {
    comment = "Generate documentation based on the source code.";
    groups = with groups.members; [
      generation
    ];
    script = ''
      ${nixBuildCommand ".#docs"}
      cp -r result/* docs/
      chmod -R +w docs/*
    '';
  };

  list-flake-inputs = {
    comment = "List project's flake inputs.";
    groups = with groups.members; [
      generation
    ];
    script = ''
      nix flake metadata --json . | jq -r '.locks.nodes.root.inputs[]'
    '';
  };

  run-integration-tests = {
    comment = "Run tests using example nix-chad setups.";
    declarations = ''
      ci := env_var_or_default("CI", "false") 
      conf_attr := "darwinConfigurations.macbook.aarch64-darwin.system"
      github_repo := "mstream/nix-chad"
      repo_root := justfile_directory()
    '';
    groups = with groups.members; [
      test
    ];
    script = ''
      if [[ "{{ci}}" = "true" ]]; then
        echo "CI runs on Linux machines as MacOS ones are 10 times as expensive."
        echo "Therefore, this suite of test will be executed only from development machine."
        echo "Skipping integration tests..."
        exit 0
      fi

      cd "{{repo_root}}/examples/minimal"
      nix flake update
      ${nixBuildCommand ".#{{conf_attr}}"}

      cd "{{repo_root}}/examples/custom"
      nix flake update
      ${nixBuildCommand ".#{{conf_attr}}"}

      cd "$(mktemp -d)"
      nix flake init --template "{{repo_root}}"
      sed "s%github:{{github_repo}}/main%git+file:{{repo_root}}?shallow=1%g" flake.nix >tmp.nix && mv tmp.nix flake.nix
      nix flake update
      ${nixBuildCommand ".#{{conf_attr}}"}
    '';
  };

  run-lints = {
    comment = "Run all linters.";
    groups = with groups.members; [
      check
    ];
    script = ''
      ${nixBuildCommand ".#lint-all"}
    '';
  };

  run-unit-tests = {
    comment = "run tests based on evaluating nix expressions.";
    groups = with groups.members; [
      test
    ];
    script = chadLib.nixCli.runCommand {
      command = "flake check --all-systems --show-trace";
      showFullLogsOnError = true;
    };
  };

  validate-project = {
    comment = "Run all checks and tests.";
    groups = with groups.members; [
      check
      test
    ];
    hooks = {
      after = [
        "check-debug"
        "check-generation"
      ];
      before = [
        "run-lints"
        "run-unit-tests"
        "run-integration-tests"
      ];
    };
    script = ''
      echo "Project validation has finished successfully."
    '';
  };
}
