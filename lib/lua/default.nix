chadLib: rec {
  description = "lua code generation helpers";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
