{
  chadLib,
  directions,
  keys,
  modes,
  searchOptions,
  ...
}:
let
  foldIntegersBetween1And9IntoAttrs =
    integerToSingleton:
    chadLib.core.foldl' (acc: i: acc // integerToSingleton i) { } [
      1
      2
      3
      4
      5
      6
      7
      8
      9
    ];
  callPreset =
    path:
    import path {
      inherit
        directions
        foldIntegersBetween1And9IntoAttrs
        keys
        modes
        searchOptions
        ;
    };
in
{
  custom = callPreset ./custom;
  standard = callPreset ./standard;
  unlockFirst = callPreset ./unlock-first;
}
