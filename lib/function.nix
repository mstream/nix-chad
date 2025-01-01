{ lib, ... }:
{
  compose = lib.trivial.flip lib.trivial.pipe;
}
