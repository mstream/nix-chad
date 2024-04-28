{ pkgs, ... }:
with pkgs; [
  djlint
  google-java-format
  hadolint
  jq
  luajitPackages.luacheck
  markdownlint-cli
  nixfmt
  nodePackages.prettier
  nodePackages.purs-tidy
  python311Packages.autopep8
  python311Packages.flake8
  python311Packages.mdformat
  shellcheck
  shfmt
  stylua
  yamllint
]
