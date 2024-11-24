{ pkgs, ... }:
let
  editorConfigText = builtins.readFile ./.editorconfig;
  formatterCommand =
    cmd: "[ ! -f .editorconfig ] && echo '${editorConfigText} || ${cmd}'";
  documentWidth = 72;
in
{
  formatters = {
    beautysh = {
      cmd = "${pkgs.beautysh}/bin/beautysh $filename";
      ext = ".sh";
    };
    nixfmt = {
      cmd = "${pkgs.nixfmt-rfc-style}/bin/nixfmt --width=${builtins.toString documentWidth} $filename";
      ext = ".nix";
    };
    stylua = {
      cmd = formatterCommand "${pkgs.stylua}/bin/stylua $filename";
      #cmd = "${pkgs.stylua}/bin/stylua $filename";
      ext = ".lua";
    };
  };
  linters = {
    deadnix = {
      cmd = "${pkgs.deadnix}/bin/deadnix $filename";
      ext = ".nix";
    };
    luacheck = {
      cmd = "${pkgs.luajitPackages.luacheck}/bin/luacheck --no-max-comment-line-length --no-max-line-length $filename";
      ext = ".lua";
    };
    markdown-link-check = {
      cmd = "${pkgs.nodePackages.markdown-link-check}/bin/markdown-link-check -v $filename || echo 'disabling because of missing cacerts issue'";
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
