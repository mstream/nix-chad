{ defaultGpgKey, easy-ps, fontSize, pkgs, username, version, ... }:
let
  nvchad = pkgs.callPackage ../../packages/nvchad { };

in
{
  home.stateVersion = version;

  home.file.ownProjects = {
    recursive = true;
    target = "Development/projects/${username}/.keep";
    text = "";
  };

  home.file.skyProjects = {
    recursive = true;
    target = "Development/projects/sky-uk/.keep";
    text = "";
  };

  home.file.otherProjects = {
    recursive = true;
    target = "Development/projects/other/.keep";
    text = "";
  };

  home.file.gnupgGpgAgent = {
    recursive = true;
    target = ".gnupg/gpg-agent.conf";
    text = ''
      enable-ssh-support
      default-cache-ttl 60
      max-cache-ttl 120
    '';
  };

  home.file.gnupgSshControl = {
    recursive = true;
    target = ".gnupg/sshcontrol";
    text = ''
      ${defaultGpgKey}
    '';
  };

  home.packages = with pkgs; [
    awscli
    aws-sam-cli
    bat
    cachix
    colima
    cargo
    coreutils
    dhall
    docker
    easy-ps.purs
    easy-ps.purs-tidy
    exercism
    ffmpeg
    inkscape
    gimp
    git-crypt
    gradle
    heroku
    jdk
    kubectl
    lua5_4
    maven
    mplayer
    nixfmt
    nixpkgs-fmt
    nmap
    nodejs
    nodePackages.htmlhint
    nodePackages.prettier
    nodePackages.purty
    nodePackages.typescript
    pandoc
    perl
    pinentry
    podman
    pwgen
    ripgrep
    spago
    statix
    tectonic
    tree
    unixtools.watch
    yarn
  ];

  xdg.configFile."nvim" = {
    source = "${nvchad}";
  };

  programs = {
    alacritty = import ./programs/alacritty/default.nix {
      inherit fontSize;
    };
    bat = import ./programs/bat/default.nix;
    browserpass = import ./programs/browserpass/default.nix;
    direnv = import ./programs/direnv/default.nix;
    firefox = (import ./programs/firefox/default.nix {
      inherit fontSize pkgs username;
    });
    git = (import ./programs/git/default.nix { inherit username; });
    gpg = (import ./programs/gpg/default.nix { inherit defaultGpgKey; });
    jq = import ./programs/jq/default.nix;
    neovim = (import ./programs/neovim/default.nix { inherit pkgs; });
    password-store = import ./programs/password-store/default.nix;
    thunderbird = (import ./programs/thunderbird/default.nix {
      inherit pkgs username;
    });
    tmux = import ./programs/tmux/default.nix;
    zsh = import ./programs/zsh/default.nix;
  };
}
