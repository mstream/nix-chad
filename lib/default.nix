{ pkgs, ... }:
{
  darwin = import ./darwin.nix;
  lua = import ./lua.nix { inherit pkgs; };
}
