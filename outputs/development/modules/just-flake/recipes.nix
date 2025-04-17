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
    hooks = {
      before = [
        "(update-flake-inputs-at \"/\")"
        "(update-flake-inputs-at \"/outputs/development/\")"
        "(update-flake-inputs-at \"/outputs/development/\")"
      ];
    };
    script = ''
      echo "Flake inputs update has finished successfully."
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
      export FLAKE_COMPAT=4f910c9827911b1ec2bf26b5a062cd09f8d89f85
      export FLAKE_PARTS=b905f6fc23a9051a6e1b741e1438dbfc0634c6de
      export FLAKE_UTILS=11707dc2f618dd54ca8739b309ec4fc024de578b
      export GIT_HOOKS=9364dc02281ce2d37a1f55b6e51f7c0f65a75f17
      export HOME_MANAGER=c61bfe3ae692f42ce688b5865fac9e0de58e1387;
      export JUST_FLAKE=0e33952a4bcd16cd54ee3aba8111606c237d4526
      export LINT_NIX=a3e8324baec349dd65c3bd8f84a56ab295ff507f
      export NIX_DARWIN=fc843893cecc1838a59713ee3e50e9e7edc6207c
      export NIX_UNIT=d867d72d21da3b7d83f0feef73b0ac7f72b16437
      export NIXPKGS_FIREFOX_DARWIN=15af0f840ee472125a4dfc81944122f3545eb5ef;
      export NIXPKGS=86484f6076aac9141df2bfcddbf7dcfce5e0c6bb
      export NIXVIM=a22fbed4c4784e6a9761f9a896d31da98c3117b2
      export NUR=5bf59d957faa081789670c5a464bce4a5d6bd01a;
      export NUSCHTOS_SEARCH=374adb7fb2c751f679519f8db532f726488293a0
      export TREEFMT_NIX=bebf27d00f7d10ba75332a0541ac43676985dea3
      export YANTS=8f0da0dba57149676aa4817ec0c880fbde7a648d
      directory="{{repo_root}}{{repo_path}}"
      flake_template_path="''${directory}flake.template.nix" 
      flake_path="''${directory}flake.nix"
      cat $flake_template_path | envsubst > $flake_path 
      nix flake lock $directory
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
