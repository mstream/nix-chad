{ chadLib, ... }:
let
  showNonPrintableCharacterSymbolsMapping = chadLib.functions.compose [
    (chadLib.attrsets.mapAttrsToList (name: symbol: "${name}:${symbol}"))
    (chadLib.strings.concatStringsSep ",")
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
