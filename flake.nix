{
  description = "An opinionated MacOS setup.";

  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts?rev=17c9d6cdfc60c64f4ee8d306f9bc0b4ccb51481e";
    };
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
    nixpkgs.url = "github:nixos/nixpkgs?ref=21ea275a7c46aef9d4d6ddc962e6d562e9d94183";
    yants = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:divnix/yants?rev=8f0da0dba57149676aa4817ec0c880fbde7a648d";
    };
  };

  outputs = inputs: import ./outputs inputs "26.05";
}
