{
  description = "An opinionated MacOS setup.";

  inputs = {
    darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin/master";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts/main";
    };
    flake-utils.url = "github:numtide/flake-utils/main";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
    just-flake.url = "github:juspay/just-flake/main";
    lint-nix.url = "github:xc-jp/lint.nix/master";
    nix-to-lua.url = "github:BirdeeHub/nixToLua/master";
    nix-unit = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nix-unit";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin/main";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "darwin";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nixvim/nixos-24.11";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR/master";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix/main";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants/main";
    };
  };

  outputs =
    inputs@{
      just-flake,
      flake-parts,
      flake-utils,
      lint-nix,
      nix-unit,
      nixpkgs,
      treefmt-nix,
      yants,
      ...
    }:
    let
      name = "nix-chad";

      ciSystems = with flake-utils.lib.system; [
        aarch64-darwin
        x86_64-darwin
        x86_64-linux
      ];

      supportedSystems = with flake-utils.lib.system; [
        aarch64-darwin
        x86_64-darwin
      ];

      forEachSystem = systems: f: builtins.foldl' f { } systems;

      mkLib =
        pkgs:
        import ./lib {
          inherit pkgs yants;
        };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        lib.chad =
          config:
          forEachSystem supportedSystems (
            acc: system:
            let
              darwin = import ./darwin.nix;
              pkgs = import nixpkgs { inherit system; };
              lib = mkLib pkgs;
            in
            lib.attrsets.recursiveUpdate acc {
              apps.${system}.switch = flake-utils.lib.mkApp {
                drv = import ./packages/switch { inherit pkgs system; };
              };
              darwinConfigurations.macbook.${system} =
                darwin.makeSystem inputs lib system
                  config;
            }
          );
        templates.default = {
          description = "A default template";
          path = ./templates/default;
        };
      };
      imports = [
        just-flake.flakeModule
        nix-unit.modules.flake.default
        treefmt-nix.flakeModule
      ];
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        let
          lib = mkLib pkgs;

        in
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = import ./overlays/nixpkgs.nix inputs;
          };

          devShells.default = pkgs.mkShell {
            inherit name;
            buildInputs = [ pkgs.node2nix ];
            inputsFrom = [ config.just-flake.outputs.devShell ];
            /*
              shellHook =
                let
                  promptPrefix = "\[\e[33m\][\[\e[m\]\[\e[34;40m\]";
                  promptSuffix = ":\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\] ";
                in
                ''
                  PS1="${promptPrefix}${name}${promptSuffix}"
                '';
            */
          };

          just-flake.features = {
            checkGeneration = {
              enable = true;
              justfile = ''
                check-generation:
                  #!/usr/bin/env bash
                  set -euxo pipefail

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
            generateDocumentation = {
              enable = true;
              justfile = ''
                generate-documentation:
                  #!/usr/bin/env bash
                  set -euxo pipefail

                  nix build .#docs
                  cp -r result/* docs/
                  chmod -R +w docs/*
              '';
            };
            listFlakeInputs = {
              enable = true;
              justfile = ''
                list-flake-inputs:
                  #!/usr/bin/env bash
                  set -euxo pipefail
                  nix flake metadata --json . | jq -r '.locks.nodes.root.inputs[]'
              '';
            };
            runAllTests = {
              enable = true;
              justfile = ''
                run-all-tests: run-lints run-unit-tests run-integration-tests && check-generation
                  #!/usr/bin/env bash
                  set -euxo pipefail

                  echo "All tests have passed."
              '';
            };
            runIntegrationTests = {
              enable = true;
              justfile = ''
                ci := env_var_or_default("CI", "false") 
                repo_root := justfile_directory()
                installable := "darwinConfigurations.macbook.aarch64-darwin.system"

                run-integration-tests: 
                  #!/usr/bin/env bash
                  set -euxo pipefail

                  if [[ "{{ci}}" != "true" ]]; then
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
            runLints = {
              enable = true;
              justfile = ''
                run-lints: 
                  #!/usr/bin/env bash
                  set -euxo pipefail

                  if ! nix build --print-build-logs --show-trace ".#lints.all-checks"; then
                    echo "coding style is not up to standards" >&2
                    exit 1
                  fi
              '';
            };
            runUnitTests = {
              enable = true;
              justfile = ''
                run-unit-tests: 
                  #!/usr/bin/env bash
                  set -euxo pipefail

                  if ! nix flake check --all-systems --show-trace; then
                    echo "nix flake does not evaluate properly" >&2
                    exit 1
                  fi
              '';
            };
          };

          legacyPackages.lints = pkgs.callPackage lint-nix.lib.lint-nix {
            inherit (import ./lint-conf.nix { inherit pkgs; }) formatters linters;
            src = ./.;
          };

          nix-unit = {
            inherit inputs;
            tests = pkgs.callPackage ./test {
              inherit lib;
            };
          };

          packages =
            let
              docs = pkgs.callPackage ./packages/docs { inherit lib; };
              website = pkgs.callPackage ./packages/website { inherit docs; };
            in
            {
              inherit docs website;
            };

          treefmt = {
            projectRootFile = ".git/config";
          };
        };
      systems = ciSystems;
    };
}
