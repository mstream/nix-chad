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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { flake-utils, nixpkgs, ... }@inputs:
    let
      supportedSystems = with flake-utils.lib.system; [
        aarch64-darwin
        x86_64-darwin
      ];

      # This should be manually adjusted to match the home-manager's 
      # flake release revision frome the flake.nix inputs section.
      home-manager-version = "23.05";
      mk-darwin-config = import ./lib/mk-darwin-config.nix
        (inputs // { inherit home-manager-version; });
    in
    {
      lib.chad = config: builtins.foldl'
        (acc: system:
          let pkgs = import nixpkgs { inherit system; };
          in pkgs.lib.recursiveUpdate acc {
            darwinConfigurations.macbook.${system} = mk-darwin-config system config;
          }
        )
        { }
        supportedSystems;
      templates.default = {
        description = "A default template";
        path = ./templates/default;
      };
    }
    //
    flake-utils.lib.eachSystem
      supportedSystems
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          apps.switch = flake-utils.lib.mkApp
            {
              drv = import ./packages/switch/default.nix { inherit pkgs system; };
            };
        });
}
