{ pkgs, ... }: with pkgs; [
  djlint
  google-java-format
  jq
  markdownlint-cli
  nodePackages.prettier
  nodePackages.purs-tidy
  python311Packages.autopep8
  python311Packages.flake8
  python311Packages.mdformat
  shellcheck
  shfmt
  yamllint
]
