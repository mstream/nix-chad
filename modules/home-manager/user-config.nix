{ easy-ps, pkgs, version, ... }:
{ defaultGpgKey, fontSize, homeDirectories, username, ... }:
let
  nvchad = pkgs.callPackage ../../packages/nvchad { };
  userDefinedDirectories = (builtins.foldl'
    (acc: dir:
      {
        idx = acc.idx + 1;
        result =
          acc.result
          // {
            "homeDirectory${builtins.toString acc.idx}" = {
              recursive = true;
              target = "${dir}/.keep";
              text = "";
            };
          };
      }
    )
    { idx = 0; result = { }; }
    homeDirectories).result;
  homeFiles = pkgs.lib.recursiveUpdate
    {
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
          ${defaultGpgKey}
        '';
      };
    }
    userDefinedDirectories;
in
{
  home.file = homeFiles;

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
    python311
    python311Packages.grip
    pwgen
    ripgrep
    spago
    statix
    tectonic
    terraform
    tree
    unixtools.watch
    yarn
  ];

  home.stateVersion = version;

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
