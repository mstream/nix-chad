{
  chadLib,
  mappings,
  pkgs,
  ...
}:
pkgs.writeTextFile {
  name = "shortcutsSpec.json";
  text = chadLib.core.toJSON mappings;
}
