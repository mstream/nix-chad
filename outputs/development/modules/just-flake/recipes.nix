{
  chadLib,
  groups,
  nixBuildCommand,
  ...
}:
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
      rm -f docs 
      mkdir docs
      cp -r result/* docs/
      chmod -R +w docs/*
    '';
  };

  get-commit-id = {
    arguments = [
      "repo"
      "branch"
    ];
    comment = "Gets commit ID by reference.";
    isPrivate = false;
    script = ''
      git ls-remote "https://github.com/{{repo}}.git" | grep refs/heads/{{branch}}$ | cut -f 1
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

  update-flake-inputs = {
    comment = "Run all checks and tests.";
    groups = with groups.members; [
      generation
    ];
    script = ''
      FLAKE_COMPAT=$({{call_recipe}} get-commit-id edolstra/flake-compat master)
      export FLAKE_COMPAT

      FLAKE_PARTS=$({{call_recipe}} get-commit-id hercules-ci/flake-parts main)
      export FLAKE_PARTS

      FLAKE_UTILS=$({{call_recipe}} get-commit-id numtide/flake-utils main)
      export FLAKE_UTILS

      GIT_HOOKS=$({{call_recipe}} get-commit-id cachix/git-hooks.nix master)
      export GIT_HOOKS

      HOME_MANAGER=$({{call_recipe}} get-commit-id nix-community/home-manager release-24.11)
      export HOME_MANAGER

      JUST_FLAKE=$({{call_recipe}} get-commit-id juspay/just-flake main)
      export JUST_FLAKE

      LINT_NIX=$({{call_recipe}} get-commit-id xc-jp/lint.nix master)
      export LINT_NIX

      NIX_DARWIN=$({{call_recipe}} get-commit-id nix-darwin/nix-darwin nix-darwin-24.11)
      export NIX_DARWIN

      NIX_UNIT=$({{call_recipe}} get-commit-id nix-community/nix-unit main)
      export NIX_UNIT

      NIXPKGS_FIREFOX_DARWIN=$({{call_recipe}} get-commit-id bandithedoge/nixpkgs-firefox-darwin main)
      export NIXPKGS_FIREFOX_DARWIN

      NIXPKGS=$({{call_recipe}} get-commit-id NixOS/nixpkgs nixpkgs-24.11-darwin)
      export NIXPKGS

      NIXVIM=$({{call_recipe}} get-commit-id nix-community/nixvim nixos-24.11)
      export NIXVIM

      NUR=$({{call_recipe}} get-commit-id nix-community/NUR main)
      export NUR

      NUSCHTOS_SEARCH=$({{call_recipe}} get-commit-id NuschtOS/search main)
      export NUSCHTOS_SEARCH

      TREEFMT_NIX=$({{call_recipe}} get-commit-id numtide/treefmt-nix main)
      export TREEFMT_NIX

      YANTS=$({{call_recipe}} get-commit-id divnix/yants main)
      export YANTS

      {{call_recipe}} update-flake-inputs-at /
      {{call_recipe}} update-flake-inputs-at /outputs/development/
      {{call_recipe}} update-flake-inputs-at /outputs/public/
    '';
  };

  update-flake-inputs-at = {
    arguments = [ "repo_path" ];
    comment = "Update public flake inputs.";
    groups = with groups.members; [
      generation
    ];
    isPrivate = true;
    script = ''
      directory="{{repo_root}}{{repo_path}}"
      flake_template_path="''${directory}flake.template.nix" 
      flake_backup_path="''${directory}flake.backup.nix" 
      flake_path="''${directory}flake.nix"
      cp $flake_path $flake_backup_path
      cat $flake_template_path | envsubst --no-empty > $flake_path 
      nix flake lock $directory || cp $flake_backup_path $flake_path
      rm $flake_backup_path
    '';
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
