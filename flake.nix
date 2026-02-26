{
  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=57928607ea566b5db3ad13af0e57e921e6b12381";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    nixpkgs.url = "github:nixos/nixpkgs?ref=e764fc9a405871f1f6ca3d1394fb422e0a0c3951";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = inputs: import ./outputs inputs "25.11";
}
