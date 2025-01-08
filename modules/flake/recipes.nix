{ groups, ... }:
{
  check-generation = {
    comment = "Check if generation has run since last source changes.";
    groups = with groups.members; [
      check
      generation
    ];
    script = ''
      if [[ $(git diff HEAD --stat) != "" ]]; then
          echo "changes to git working directory after detected:"
          echo "vvv"
          git status
          git diff HEAD
          echo "^^^"
          echo "aborting"
          exit 1
      else
          echo "git branch is clean"
      fi
    '';
  };

  generate-documentation = {
    comment = "Generate documentation based on the source code.";
    groups = with groups.members; [
      generation
    ];
    script = ''
      nix build .#docs
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
      repo_root := justfile_directory()
      installable := "darwinConfigurations.macbook.aarch64-darwin.system"
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
        if ! nix build --show-trace "./#{{installable}}"; then
          echo "minimal example is broken" >&2
          exit 1
        fi

        cd "{{repo_root}}/examples/custom"
        nix flake update
        if ! nix build --show-trace "./#{{installable}}"; then
          echo "custom example is broken" >&2
          exit 1
        fi

        cd "$(mktemp -d)"
        nix flake init --template "{{repo_root}}"
        sed "s%github:mstream/nix-chad/main%git+file:{{repo_root}}?shallow=1%g" flake.nix >tmp.nix && mv tmp.nix flake.nix
        nix flake update
        if ! nix build --show-trace "./#{{installable}}"; then
          echo "template is broken" >&2
          exit 1
        fi
    '';
  };

  run-lints = {
    comment = "Run all linters.";
    groups = with groups.members; [
      check
    ];
    script = ''
      if ! nix build --print-build-logs --show-trace ".#lints.all-checks"; then
        echo "coding style is not up to standards" >&2
        exit 1
      fi
    '';
  };

  run-unit-tests = {
    comment = "run tests based on evaluating nix expressions.";
    groups = with groups.members; [
      test
    ];
    script = ''
      if ! nix flake check --all-systems --show-trace; then
        echo "nix flake does not evaluate properly" >&2
        exit 1
      fi
    '';
  };

  validate-project = {
    comment = "Run all checks and tests.";
    groups = with groups.members; [
      check
      test
    ];
    hooks = {
      after = [ "check-generation" ];
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
