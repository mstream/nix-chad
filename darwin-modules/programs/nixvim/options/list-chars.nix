{ lib, ... }:
let
  showNonPrintableCharacterSymbolsMapping = lib.function.compose [
    (lib.attrsets.mapAttrsToList (name: symbol: "${name}:${symbol}"))
    (lib.strings.concatStringsSep ",")
  ];
in
showNonPrintableCharacterSymbolsMapping {
  conceal = "⚿";
  eol = "↵";
  extends = "»";
  precedes = "«";
  space = "␣";
  tab = "——⇥";
}
