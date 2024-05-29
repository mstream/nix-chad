{
  description = "An opinionated MacOS setup.";

  inputs = {
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lint-nix.url = "github:xc-jp/lint.nix";
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    nur.url = "github:nix-community/NUR";
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

      lib = import ./lib;
    in
    {
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
          in
          pkgs.lib.recursiveUpdate acc {
            apps.${system}.switch = inputs.flake-utils.lib.mkApp {
              drv = import ./packages/switch/default.nix { inherit pkgs system; };
            };
            darwinConfigurations.macbook.${system} = lib.darwin.makeSystem inputs system config;
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
        _: system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
            };
            overlays = import ./overlays/nixpkgs.nix { inherit (inputs) nur; };
          };
          violations = import ./test { inherit pkgs; };
        in
        if violations == [ ] then "all tests passed" else throw (builtins.toJSON violations)
      );
    };
}
