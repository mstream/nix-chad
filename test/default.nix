{ chadLib, ... }:
let
  loadTestSuite =
    suiteTitle: path:
    let
      suite = import path { inherit chadLib; };
    in
    chadLib.attrsets.foldlAttrs (
      acc: testTitle: test:
      acc
      // {
        "test_${suiteTitle}_${testTitle}" = test;
      }
    ) { } suite;

  testSuiteFiles = {
    "docs" = ./docs.nix;
    "enum" = ./enum.nix;
    "zsh-abbreviations" = ./zsh-abbreviations.nix;
  };
in
chadLib.attrsets.mergeAttrsList (
  chadLib.core.attrValues (
    chadLib.core.mapAttrs loadTestSuite testSuiteFiles
  )
)
