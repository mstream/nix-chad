{ pkgs, ... }:
{
  formatters = {
    beautysh = {
      cmd = "${pkgs.beautysh}/bin/beautysh --check $filename";
      ext = ".sh";
    };
    nixpkgs-fmt = {
      cmd = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt --check $filename";
      ext = ".nix";
    };
    stylua = {
      cmd = "${pkgs.stylua}/bin/stylua --check $filename";
      ext = ".lua";
    };
  };
  linters = {
    deadnix = {
      cmd = "${pkgs.deadnix}/bin/deadnix $filename";
      ext = ".nix";
    };
    luacheck = {
      cmd = "${pkgs.luajitPackages.luacheck}/bin/luacheck $filename --globals vim";
      ext = ".lua";
    };
    shellcheck = {
      cmd = "${pkgs.shellcheck}/bin/shellcheck $filename";
      ext = ".sh";
    };
    statix = {
      cmd = "${pkgs.statix}/bin/statix check -- $filename";
      ext = ".nix";
    };
  };
}
