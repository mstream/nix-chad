{
  description = "An opinionated MacOS setup.";

  inputs = {
    darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin/master";
    };
    flake-utils.url = "github:numtide/flake-utils/main";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
    lint-nix.url = "github:xc-jp/lint.nix/master";
    nix-to-lua.url = "github:BirdeeHub/nixToLua/master";
    nix-unit = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-unit";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin/main";
    };
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/main";
    };
    nur = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NUR/master";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants/main";
    };
  };

  outputs =
    inputs:
    let
      name = "nix-chad";

      ciSystems = with inputs.flake-utils.lib.system; [
        aarch64-darwin
        x86_64-darwin
        x86_64-linux
      ];

      supportedSystems = with inputs.flake-utils.lib.system; [
        aarch64-darwin
        x86_64-darwin
      ];

      forEachSystem = systems: f: builtins.foldl' f { } systems;
    in
    {
      apps = forEachSystem ciSystems (
        acc: system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        pkgs.lib.recursiveUpdate acc {
          ${system}.nix-unit = {
            program = "${inputs.nix-unit.packages.${system}.default}/bin/nix-unit";
            type = "app";
          };
        }
      );
      devShells = forEachSystem ciSystems (
        acc: system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        pkgs.lib.recursiveUpdate acc {
          ${system}.default = pkgs.mkShell {
            inherit name;
            buildInputs = [ pkgs.node2nix ];
            shellHook = ''
              PS1="\[\e[33m\][\[\e[m\]\[\e[34;40m\]${name}:\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\] "
            '';
          };
        }
      );
      legacyPackages = forEachSystem ciSystems (
        acc: system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        pkgs.lib.recursiveUpdate acc {
          ${system}.lints = inputs.lint-nix.lib.lint-nix {
            inherit pkgs;
            inherit (import ./lint-conf.nix { inherit pkgs; }) formatters linters;
            src = ./.;
          };
        }
      );
      lib.chad =
        config:
        forEachSystem supportedSystems (
          acc: system:
          let
            pkgs = import inputs.nixpkgs { inherit system; };
            inherit (import ./lib { inherit pkgs; }) darwin;
          in
          pkgs.lib.recursiveUpdate acc {
            apps.${system}.switch = inputs.flake-utils.lib.mkApp {
              drv = import ./packages/switch/default.nix { inherit pkgs system; };
            };
            darwinConfigurations.macbook.${system} =
              darwin.makeSystem inputs system
                config;
          }
        );
      packages = forEachSystem ciSystems (
        acc: system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        pkgs.lib.recursiveUpdate acc {
          ${system} = {
            docs = import ./packages/docs { inherit pkgs; };
            website = import ./packages/website { inherit pkgs; };
          };
        }
      );
      templates.default = {
        description = "A default template";
        path = ./templates/default;
      };
      tests = forEachSystem ciSystems (
        acc: system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
            };
            overlays = import ./overlays/nixpkgs.nix {
              inherit (inputs) nixpkgs-firefox-darwin nur;
            };
          };
        in
        pkgs.lib.recursiveUpdate acc {
          ${system} = import ./test { inherit pkgs; };
        }
      );
    };
}
