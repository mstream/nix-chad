{ pkgs, ... }:
with pkgs; [
  djlint
  google-java-format
  hadolint
  jq
  luajitPackages.luacheck
  markdownlint-cli
  nixfmt-classic
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
