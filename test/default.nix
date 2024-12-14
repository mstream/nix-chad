{ lib, ... }:
let
  loadTestSuite =
    suiteTitle: path:
    let
      suite = import path { inherit lib; };
    in
    lib.attrsets.foldlAttrs (
      acc: testTitle: test:
      acc
      // {
        "test_${suiteTitle}_${testTitle}" = test;
      }
    ) { } suite;

  testSuiteFiles = {
    "docs" = ./docs.nix;
    "enum" = ./enum.nix;
    "lua" = ./lua.nix;
    "zsh-abbreviations" = ./zsh-abbreviations.nix;
  };
in
lib.attrsets.mergeAttrsList (
  lib.core.attrValues (lib.core.mapAttrs loadTestSuite testSuiteFiles)
)
