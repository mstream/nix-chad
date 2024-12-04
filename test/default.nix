{ pkgs, ... }:
with pkgs.lib;
let
  loadTestSuite =
    suiteTitle: path:
    let
      suite = import path {
        inherit pkgs;
        suiteTitle = title;
      };
    in
    attrsets.foldlAttrs (
      acc: testTitle: test:
      acc
      // {
        "test_${suiteTitle}_${testTitle}" = test;
      }
    ) { } suite;

  testSuiteFiles = {
    "docs" = ./docs.nix;
    "lua" = ./lua.nix;
    "zsh-abbreviations" = ./zsh-abbreviations.nix;
  };
in
mergeAttrsList (attrValues (mapAttrs loadTestSuite testSuiteFiles))
