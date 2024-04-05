{ pkgs, ... }: with pkgs; [
  dhall-lsp-server
  dockerfile-language-server-nodejs
  lua-language-server
  efm-langserver
  java-language-server
  marksman
  nixd
  nodePackages.bash-language-server
  nodePackages.purescript-language-server
  nodePackages.typescript-language-server
  nodePackages.vscode-html-languageserver-bin
  nodePackages.vscode-json-languageserver
  nodePackages.yaml-language-server
  python311Packages.jedi-language-server
  typescript
]
