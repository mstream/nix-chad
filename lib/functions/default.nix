chadLib: rec {
  description = "functions";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
