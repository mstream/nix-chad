{
  description = "Public partition inputs.";

  inputs = {
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin?rev=74ecd01d2c122f8a4a48066ab1d48f3e01671671";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat?rev=9100a0f413b0c601e0533d1d94ffd501ce2e7885";
    };
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=c621e8422220273271f52058f618c94e405bb0f5";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix?rev=80479b6ec16fefd9c1db3ea13aeb038c60530f46";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?rev=d0bbd221482c2713cccb80220f3c9d16a6e20a33";
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=e041816285df65c0e53bcc951782a2a69869a443";
    nixpkgs-firefox-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:bandithedoge/nixpkgs-firefox-darwin?rev=214f1e0b31352897f61274a140fd79737245c803";
    };
    nixvim = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
      url = "github:nix-community/nixvim?rev=6ef96cb478bfe4388472746f2b356467e83b7a88";
    };
    nur = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:nix-community/NUR?rev=44f48704dcbda797c6fe472d7635e7c54eaf3cb9";
    };
    nuschtos-search = {
      url = "github:NuschtOS/search?rev=066afe8643274470f4a294442aadd988356a478f";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix?rev=ab0378b61b0d85e73a8ab05d5c6029b5bd58c9fb";
    };
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = _: { };
}
