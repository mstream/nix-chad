chadLib: rec {
  description = "strings manipulation";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
