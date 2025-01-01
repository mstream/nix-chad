{ nixpkgsLib, ... }:
{
  compose = nixpkgsLib.trivial.flip nixpkgsLib.trivial.pipe;
}
