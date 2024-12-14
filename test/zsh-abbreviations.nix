{ lib, ... }:
let
  zshAbbreviations =
    import ../darwin-modules/home-manager/programs/zsh/abbreviations.nix
      {
        inherit lib;
      };
  mergedAbbreviations = zshAbbreviations.mergeAbbreviations [
    {
      a = "a";
      b = "b";
    }
    { c = "c"; }
  ];
in
{
  testMergingAbbreviations = {
    expected = {
      a = "a";
      b = "b";
      c = "c";
    };
    expr = mergedAbbreviations;
  };
}
