{ easy-ps, pkgs, version, ... }:
let
  userConfig = import ../modules/home-manager/user-config.nix;
  actual = userConfig
    { inherit easy-ps pkgs version; }
    {
      defaultGpgKey = "gpg1";
      extraPackages = [ "cowsay" ];
      fontSize = 123;
      homeDirectories = [ "dir1/dirA" "dir1/dirB" "dir2/dirA" ];
      username = "user1";
    };
in
pkgs.lib.runTests
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
    expr = actual.home.file;
  };
  testHomePackages = {
    expected = with pkgs; [
      dhall-lsp-server
      java-language-server
      lua-language-server
      nodePackages.bash-language-server
      nodePackages.markdownlint-cli
      nodePackages.purescript-language-server
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      rnix-lsp
      awscli
      aws-sam-cli
      bat
      beautysh
      black
      cachix
      colima
      cargo
      cbfmt
      checkstyle
      codespell
      commitlint
      coreutils
      deadnix
      deno
      dhall
      docker
      easy-ps.purs
      easy-ps.purs-tidy
      editorconfig-checker
      exercism
      ffmpeg
      gawk
      gimp
      git-crypt
      google-java-format
      gradle
      hadolint
      inkscape
      heroku
      jdk
      kubectl
      lua5_4
      luajitPackages.luacheck
      maven
      mdl
      mplayer
      nixfmt
      nixpkgs-fmt
      nmap
      nodejs
      nodePackages.alex
      nodePackages.fixjson
      nodePackages.htmlhint
      nodePackages.jsonlint
      nodePackages.prettier
      nodePackages.prettier_d_slim
      nodePackages.purty
      nodePackages.pyright
      nodePackages.stylelint
      nodePackages.textlint
      nodePackages.typescript
      nodePackages.write-good
      pandoc
      perl
      pinentry
      podman
      proselint
      python311
      python311Packages.grip
      pwgen
      ripgrep
      treefmt
      shellcheck
      shellharden
      shfmt
      spago
      statix
      stylua
      taplo
      tectonic
      terraform
      tfsec
      tree
      typos
      unixtools.watch
      xmlformat
      yamlfix
      yamllint
      yarn
      cowsay
    ];
    expr = actual.home.packages;
  };
}
