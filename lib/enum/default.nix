chadLib: rec {
  description = "enumerations";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
