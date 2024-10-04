{ pkgs, ... }:
let
  userConfig = import ../modules/home-manager/user-config.nix;
  osConfig.chad = {
    gpg.defaultKey = "gpg1";
    extraPackages = pkgs: [ pkgs.cowsay ];
    fontSize = 123;
    software.openSourceOnly = false;
    user = {
      homeDirectories = [
        "dir1/dirA"
        "dir1/dirB"
        "dir2/dirA"
      ];
      name = "user1";
    };
  };
in
{
  testHomeFiles = {
    expected = {
      gnupgGpgAgent = {
        recursive = true;
        target = ".gnupg/gpg-agent.conf";
        text = ''
          enable-ssh-support
          default-cache-ttl 60
          max-cache-ttl 120
        '';
      };
      gnupgSshControl = {
        recursive = true;
        target = ".gnupg/sshcontrol";
        text = ''
          gpg1
        '';
      };
      homeDirectory0 = {
        recursive = true;
        target = "dir1/dirA/.keep";
        text = "";
      };
      homeDirectory1 = {
        recursive = true;
        target = "dir1/dirB/.keep";
        text = "";
      };
      homeDirectory2 = {
        recursive = true;
        target = "dir2/dirA/.keep";
        text = "";
      };
    };
    expr = (userConfig { inherit osConfig pkgs; }).home.file;
  };
  testAllHomePackages = {
    expected = with pkgs; [
      fd
      ripgrep
      tree-sitter
      actionlint
      commitlint
      djlint
      google-java-format
      hadolint
      jq
      luajitPackages.luacheck
      markdownlint-cli
      nixfmt-rfc-style
      nodePackages.prettier
      nodePackages.purs-tidy
      python311Packages.autopep8
      python311Packages.flake8
      python311Packages.mdformat
      shellcheck
      shfmt
      stylua
      python311Packages.yamllint
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
      spago
      typescript
      luajitPackages.jsregexp
      nerdfonts
      bat
      coreutils
      docker
      editorconfig-checker
      gawk
      nmap
      nodejs
      nodePackages.node2nix
      tldr
      tree
      unixtools.watch
      jetbrains.idea-ultimate
      cowsay
    ];
    expr = (userConfig { inherit osConfig pkgs; }).home.packages;
  };
  testOpenSourceOnlyHomePackages = {
    expected = with pkgs; [
      fd
      ripgrep
      tree-sitter
      actionlint
      commitlint
      djlint
      google-java-format
      hadolint
      jq
      luajitPackages.luacheck
      markdownlint-cli
      nixfmt-rfc-style
      nodePackages.prettier
      nodePackages.purs-tidy
      python311Packages.autopep8
      python311Packages.flake8
      python311Packages.mdformat
      shellcheck
      shfmt
      stylua
      python311Packages.yamllint
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
      spago
      typescript
      luajitPackages.jsregexp
      nerdfonts
      bat
      coreutils
      docker
      editorconfig-checker
      gawk
      nmap
      nodejs
      nodePackages.node2nix
      tldr
      tree
      unixtools.watch
      cowsay
    ];
    expr =
      (userConfig {
        inherit pkgs;
        osConfig = osConfig // {
          chad = osConfig.chad // {
            software.openSourceOnly = true;
          };
        };
      }).home.packages;
  };
}
