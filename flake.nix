{

  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=b905f6fc23a9051a6e1b741e1438dbfc0634c6de";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    nixpkgs.url = "github:nixos/nixpkgs?ref=a6fb7237cd4b325a8a75e0eab9e43caa94fcd3f1";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = inputs: import ./outputs inputs;
}
