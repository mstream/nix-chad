{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=fc843893cecc1838a59713ee3e50e9e7edc6207c";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=4f910c9827911b1ec2bf26b5a062cd09f8d89f85";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=b905f6fc23a9051a6e1b741e1438dbfc0634c6de";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=9364dc02281ce2d37a1f55b6e51f7c0f65a75f17";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=0948aeedc296f964140d9429223c7e4a0702a1ff";
    };
    nixpkgs.url = "github:nixos/nixpkgs?ref=453afb364c2283e67601d88de7f80132e7322eb7";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=45715697e67cb4b6260d21174086a97e1e0e14c9";
    };
    nixvim = {
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "nix-darwin";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtosSearch";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/nixvim?rev=ec72386f491c290bc77dc5fd3a6d7baf79b24680";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=374adb7fb2c751f679519f8db532f726488293a0";
    };
    nuschtosSearch = {
      url = "github:NuschtOS/search?rev=86e2038290859006e05ca7201425ea5b5de4aecb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=bebf27d00f7d10ba75332a0541ac43676985dea3";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
