chadLib: rec {
  description = "nix CLI bash command generation helpers";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
