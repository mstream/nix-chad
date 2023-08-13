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
    markdown-link-check = {
      cmd = "${pkgs.nodePackages.markdown-link-check}/bin/markdown-link-check $filename";
      ext = ".md";
    };
    shellcheck = {
      cmd = "${pkgs.shellcheck}/bin/shellcheck $filename";
      ext = ".sh";
    };
    statix = {
      cmd = "${pkgs.statix}/bin/statix check -- $filename";
      ext = ".nix";
    };
    typos = {
      cmd = "${pkgs.typos}/bin/typos $filename";
      ext = ".md";
    };
  };
}
