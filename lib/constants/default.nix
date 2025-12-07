chadLib: rec {
  description = "various constants";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
