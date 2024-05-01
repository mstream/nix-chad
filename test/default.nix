{ pkgs, version, ... }:
let
  userConfig = import ../modules/home-manager/user-config.nix;
  actualUserConfig = userConfig { inherit pkgs version; } {
    defaultGpgKey = "gpg1";
    extraPackages = [ "cowsay" ];
    fontSize = 123;
    homeDirectories = [ "dir1/dirA" "dir1/dirB" "dir2/dirA" ];
    username = "user1";
  };
in pkgs.lib.runTests {
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
    expr = actualUserConfig.home.file;
  };
  testHomePackages = {
    expected = with pkgs; [
      fd
      ripgrep
      tree-sitter
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
      typescript
      luajitPackages.jsregexp
      nerdfonts
      bat
      coreutils
      editorconfig-checker
      gawk
      jetbrains.idea-ultimate
      nmap
      nodePackages.node2nix
      tree
      unixtools.watch
      cowsay
    ];
    expr = actualUserConfig.home.packages;
  };
}
