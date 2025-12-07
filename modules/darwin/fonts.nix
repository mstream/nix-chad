{ chadLib, pkgs, ... }:
let
  nerdFonts = chadLib.core.filter chadLib.attrsets.isDerivation (
    chadLib.attrsets.attrValues pkgs.nerd-fonts
  );
  otherFonts = [ ];
in
{
  fonts.packages = otherFonts ++ nerdFonts;
}
