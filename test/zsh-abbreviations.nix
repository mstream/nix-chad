{ chadLib, ... }:
let
  zshAbbreviations =
    import ../modules/darwin/home-manager/programs/zsh/abbreviations.nix
      {
        inherit chadLib;
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
