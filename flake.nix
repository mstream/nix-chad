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

      chadLib = import ./lib {
        inherit yants;
        nixpkgsLib = nixpkgs.lib;
      };
    in
    flake-parts.lib.mkFlake
      {
        inherit inputs;
        specialArgs = {
          inherit chadLib;
        };
      }
      {
        flake = {
          lib.chad =
            config:
            forEachSystem supportedSystems (
              acc: system:
              let
                darwin = import ./darwin.nix;
                pkgs = import nixpkgs { inherit system; };
              in
              nixpkgs.lib.attrsets.recursiveUpdate acc {
                apps.${system}.switch = flake-utils.lib.mkApp {
                  drv = import ./packages/switch { inherit pkgs system; };
                };
                darwinConfigurations.macbook.${system} =
                  darwin.makeSystem inputs chadLib system
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
          ./modules/flake
        ];
        perSystem =
          {
            config,
            pkgs,
            system,
            ...
          }:
          {
            _module.args.pkgs = import nixpkgs {
              inherit system;
              config = {
                allowBroken = false;
                allowUnfree = true;
              };
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

            legacyPackages.lints = pkgs.callPackage lint-nix.lib.lint-nix {
              inherit (import ./lint-conf.nix { inherit pkgs; }) formatters linters;
              src = ./.;
            };

            nix-unit = {
              inherit inputs;
              tests = pkgs.callPackage ./test {
                inherit chadLib;
              };
            };

            packages =
              let
                docs = pkgs.callPackage ./packages/docs {
                  inherit
                    chadLib
                    ;
                };
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
