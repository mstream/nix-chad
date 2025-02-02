chadLib: rec {
  description = "bash code generation helpers";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
