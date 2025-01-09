chadLib: rec {
  implementation = import ./implementation.nix chadLib;
  tests = import ./tests.nix implementation;
}
