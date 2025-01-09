{
  chadLib,
  directions,
  keys,
  modes,
  searchOptions,
  ...
}:
let
  foldIntegersBetween1And9IntoAttrs = chadLib.attrsets.generate (
    chadLib.lists.range 1 9
  );

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
