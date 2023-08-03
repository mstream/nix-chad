{
  description = "An opinionated MacOS setup.";

  inputs = {
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    easy-purescript-nix = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lint-nix.url = "github:xc-jp/lint.nix";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ easy-purescript-nix, flake-utils, lint-nix, nixpkgs, nur, ... }:
    let
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

      # This should be manually adjusted to match the home-manager's
      # flake release revision from the flake.nix inputs section.
      home-manager-version = "23.05";
      mk-darwin-config = import ./lib/mk-darwin-config.nix
        (inputs // { inherit home-manager-version; });
    in
    {
      legacyPackages = forEachSystem ciSystems
        (acc: system:
          let
            pkgs = import nixpkgs { inherit system; };
          in
          pkgs.lib.recursiveUpdate acc
            {
              ${system}.lints = lint-nix.lib.lint-nix {
                inherit pkgs;
                linters = {
                  deadnix = {
                    cmd = "${pkgs.deadnix}/bin/deadnix $filename";
                    ext = ".nix";
                  };
                  luacheck = {
                    cmd = "${pkgs.luajitPackages.luacheck}/bin/luacheck $filename --globals vim";
                    ext = ".lua";
                  };
                  shellcheck = {
                    cmd = "${pkgs.shellcheck}/bin/shellcheck $filename";
                    ext = ".sh";
                  };
                  statix = {
                    cmd = "${pkgs.statix}/bin/statix check -- $filename";
                    ext = ".nix";
                  };
                };
                formatters = {
                  beautysh = {
                    cmd = "${pkgs.beautysh}/bin/beautysh --check $filename";
                    ext = ".sh";
                  };
                  nixpkgs-fmt = {
                    cmd = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt --check $filename";
                    ext = ".nix";
                  };
                  stylua = {
                    cmd = "${pkgs.stylua}/bin/stylua --check $filename";
                    ext = ".lua";
                  };
                };
                src = ./.;
              };
            }
        );
      lib.chad = config: forEachSystem supportedSystems
        (acc: system:
          let pkgs = import nixpkgs { inherit system; };
          in pkgs.lib.recursiveUpdate acc {
            apps.${system}.switch = flake-utils.lib.mkApp
              {
                drv = import ./packages/switch/default.nix { inherit pkgs system; };
              };
            darwinConfigurations.macbook.${system} = mk-darwin-config system config;
          }
        );
      templates.default = {
        description = "A default template";
        path = ./templates/default;
      };
      tests = forEachSystem ciSystems
        (_: system:
          let
            pkgs = import nixpkgs
              {
                inherit system;
                overlays = import ./overlays/nixpkgs.nix { inherit nur; };
              };
            violations = import ./test.nix
              {
                inherit pkgs;
                easy-ps = import easy-purescript-nix { inherit pkgs; };
                version = home-manager-version;
              };
          in
          if violations == [ ]
          then "all tests passed"
          else throw (builtins.toJSON violations)
        );
    };
}
