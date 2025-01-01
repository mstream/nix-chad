{ chadLib, ... }:
let
  showNonPrintableCharacterSymbolsMapping = chadLib.function.compose [
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
