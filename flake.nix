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
      url = "github:nix-community/nixvim/nixos-24.11";
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
    inputs@{
      flake-parts,
      nix-unit,
      nixpkgs,
      ...
    }:
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

      mkLib =
        pkgs:
        import ./lib {
          inherit pkgs;
          inherit (inputs) yants;
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
              pkgs = import inputs.nixpkgs { inherit system; };
              lib = mkLib pkgs;
            in
            lib.attrsets.recursiveUpdate acc {
              apps.${system}.switch = inputs.flake-utils.lib.mkApp {
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
        nix-unit.modules.flake.default
      ];
      perSystem =
        { pkgs, system, ... }:
        let
          lib = mkLib pkgs;

        in
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = import ./overlays/nixpkgs.nix {
              inherit (inputs) nixpkgs-firefox-darwin nur;
            };
          };

          legacyPackages.lints = pkgs.callPackage inputs.lint-nix.lib.lint-nix {
            inherit (import ./lint-conf.nix { inherit pkgs; }) formatters linters;
            src = ./.;
          };

          nix-unit = {
            inputs = {
              inherit flake-parts nix-unit nixpkgs;
            };
            tests = pkgs.callPackage ./test {
              inherit lib;
            };
          };

          devShells.default = pkgs.mkShell {
            inherit name;
            buildInputs = [ pkgs.node2nix ];
            shellHook =
              let
                promptPrefix = "\[\e[33m\][\[\e[m\]\[\e[34;40m\]";
                promptSuffix = ":\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\] ";
              in
              ''
                PS1="${promptPrefix}${name}${promptSuffix}"
              '';
          };

          packages =
            let
              docs = pkgs.callPackage ./packages/docs { inherit lib; };
              website = pkgs.callPackage ./packages/website { inherit docs; };
            in
            {
              inherit docs website;
            };
        };
      systems = ciSystems;
    };
}
