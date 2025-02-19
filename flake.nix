{

  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=b905f6fc23a9051a6e1b741e1438dbfc0634c6de";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    nixpkgs.url = "github:nixos/nixpkgs?ref=41bc1723c8789e9c46a1bb4897022f80d2cf147d";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = inputs: import ./outputs inputs;
}
