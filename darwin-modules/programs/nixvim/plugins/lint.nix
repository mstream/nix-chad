{ lib, pkgs, ... }:
{
  programs.nixvim.plugins.lint = {
    enable = true;
    linters = {
      commitlint = {
        cmd = lib.getExe pkgs.commitlint;
      };
      statix = {
        cmd = lib.getExe pkgs.statix;
      };
      vale = {
        cmd = lib.getExe pkgs.vale;
      };
    };
    lintersByFt = {
      gitcommit = [
        "commitlint"
        "vale"
      ];
      nix = [
        "statix"
        "vale"
      ];
    };
  };
}
