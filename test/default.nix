{ easy-ps, pkgs, version, ... }:
let
  homebrew = import ../modules/homebrew;
  userConfig = import ../modules/home-manager/user-config.nix;
  actualHomebrew = homebrew {
    extraCasks = [
      "some-extra-cask-1"
      "some-extra-cask-2"
    ];
    manageHomebrew = true;
  };
  actualUserConfig = userConfig
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
    expr = actualUserConfig.home.file;
  };
  testHomebrewCasks = {
    expected = [
      "firefox"
      "google-chrome"
      "thunderbird"
      "some-extra-cask-1"
      "some-extra-cask-2"
    ];
    expr = actualHomebrew.homebrew.casks;
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
      discord
      docker
      dprint
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
      heroku
      inkscape
      jdk
      jetbrains.idea-ultimate
      jupyter
      kubectl
      lua5_4
      luajitPackages.luacheck
      maven
      mdl
      nixfmt
      nixpkgs-fmt
      nmap
      nodejs
      nodePackages.alex
      nodePackages.bower
      nodePackages.fixjson
      nodePackages.htmlhint
      nodePackages.jsonlint
      nodePackages.prettier
      nodePackages.prettier_d_slim
      nodePackages.pulp
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
      python311Packages.pip
      pwgen
      ripgrep
      treefmt
      shellcheck
      shellharden
      shfmt
      slack
      spago
      statix
      stylua
      taplo
      teams
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
      vscode
      cowsay
    ];
    expr = actualUserConfig.home.packages;
  };
}
