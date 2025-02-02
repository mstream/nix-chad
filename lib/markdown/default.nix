chadLib: rec {
  description = "markdown code generation helpers";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
