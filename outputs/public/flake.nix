{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=08585aacc3d6d6c280a02da195fdbd4b9cf083c2";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=5edf11c44bc78a0d334f6334cdaf7d60d732daab";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=57928607ea566b5db3ad13af0e57e921e6b12381";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=6e34e97ed9788b17796ee43ccdbaf871a5c2b476";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=36e38ca0d9afe4c55405fdf22179a5212243eecc";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder?rev=50e6070082e0b4fbaf67dd8f346892a1a9ed685c";
      # TODO: remove when logind.settings is backported to the darwin branch of nixpkgs
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=e764fc9a405871f1f6ca3d1394fb422e0a0c3951";
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=b8f76bf5751835647538ef8784e4e6ee8deb8f95";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=197e0b37cd38b86556175fa8818f3f57f47632b8";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=b6f77b88e9009bfde28e2130e218e5123dc66796";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=337a4fe074be1042a35086f15481d763b8ddc0e7";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
