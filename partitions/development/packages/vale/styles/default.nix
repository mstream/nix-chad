{ chadLib, pkgs, ... }:
let
  customStyles = { };
  standardStyles = pkgs.valeStyles;
in
chadLib.attrsets.merge standardStyles customStyles
