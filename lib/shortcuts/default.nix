chadLib: rec {
  description = "macOS keyboard shortcuts configuration support";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
