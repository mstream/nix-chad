{
  core,
  nixpkgsLibAttrsets,
  yants,
}:
rec {
  description = "attribute sets";
  implementation = import ./implementation {
    inherit core nixpkgsLibAttrsets yants;
  };
  tests = import ./tests implementation;
}
