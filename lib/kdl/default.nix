chadLib: rec {
  description = "KDL file format utils";
  implementation = import ./implementation chadLib;
  tests = import ./tests implementation;
}
