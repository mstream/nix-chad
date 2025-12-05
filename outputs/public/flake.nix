{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=e95de00a471d07435e0527ff4db092c84998698e";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=3b279e4317ccfa4865356387935310531357d919";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=2cccadc7357c0ba201788ae99c4dfa90728ef5e0";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=50b9238891e388c9fdc6a5c49e49c42533a1b5ce";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=f63d0fe9d81d36e5fc95497217a72e02b8b7bcab";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=ebb7162a975074fb570a2c3ac02bc543ff2e9df4";
      # TODO: remove when logind.settings is backported to the darwin branch of nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=77e2319b4114312eeeebfbc72bed0ae7fccfb112";
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=64d9e2616f4ee2acee380d61ccf1f3d610e7e969";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=7c0ea8ab53727e9f22e01b88ed5ce8f84310fb17";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=e29de6db0cb3182e9aee75a3b1fd1919d995d85b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=5b4ee75aeefd1e2d5a1cc43cf6ba65eba75e83e4";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
