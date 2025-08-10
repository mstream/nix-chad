{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=536f951efb1ccda9b968e3c9dee39fbeb6d3fdeb";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=9100a0f413b0c601e0533d1d94ffd501ce2e7885";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=af66ad14b28a127c5c0f3bbb298218fc63528a18";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=9c52372878df6911f9afc1e2a1391f55e4dfc864";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=fc3add429f21450359369af74c2375cb34a2d204";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=7ce605d5c3f86b4ce9745348be42429b6c1b1739";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=bb04824eba653c7c3ef64ee07a9d8bf7af4e17af";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=ab1b5962e1ca90b42de47e1172e0d24ca80e6256";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=08179897d21692cb0342bb5a97c358487a2ba79a";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=5bc0c67cc6f4a71fe50782aa8e90032fef2f4cc9";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=1298185c05a56bff66383a20be0b41a307f52228";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
