chadLib: rec {
  description = "lists manipulation";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
