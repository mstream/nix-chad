chadLib: rec {
  implementation = import ./implementation chadLib;
  tests = import ./tests.nix implementation;
}
