{
  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=f20dc5d9b8027381c474144ecabc9034d6a839a3";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    nixpkgs.url = "github:nixos/nixpkgs?ref=fabb8c9deee281e50b1065002c9828f2cf7b2239";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = inputs: import ./outputs inputs "25.11";
}
