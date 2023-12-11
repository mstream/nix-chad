{ easy-ps, pkgs, version, ... }:
chadConfig@{ defaultGpgKey, extraPackages, homeDirectories, ... }:
let
  lsps = with pkgs; [
    dhall-lsp-server
    java-language-server
    lua-language-server
    nodePackages.bash-language-server
    nodePackages.markdownlint-cli
    nodePackages.purescript-language-server
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    rnix-lsp
  ];
  pythonEnvironment = pkgs.python3Full.withPackages (p: [ p.grip p.pip ]);
  otherPackages = with pkgs; [
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
    poetry
    proselint
    pwgen
    pythonEnvironment
    ripgrep
    treefmt
    shellcheck
    shellharden
    shfmt
    slack
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
  ];
  customPackages = builtins.map
    (packageName: pkgs.${packageName})
    extraPackages;
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

  gnupgDirectories = if defaultGpgKey == null then { } else {
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
  };

  homeFiles = pkgs.lib.recursiveUpdate
    gnupgDirectories
    userDefinedDirectories;
in
{
  home.file = homeFiles;

  home.packages = lsps ++ otherPackages ++ customPackages;

  home.stateVersion = version;

  xdg.configFile."nvim" = {
    source = "${nvchad}";
  };

  programs = {
    alacritty = import ./programs/alacritty/default.nix chadConfig;
    bat = import ./programs/bat/default.nix;
    browserpass = import ./programs/browserpass/default.nix;
    chromium = import ./programs/chromium/default.nix { inherit pkgs; };
    direnv = import ./programs/direnv/default.nix;
    firefox = import ./programs/firefox/default.nix (chadConfig // { inherit pkgs; });
    git = import ./programs/git/default.nix chadConfig;
    gpg = import ./programs/gpg/default.nix chadConfig;
    jq = import ./programs/jq/default.nix;
    neovim = import ./programs/neovim/default.nix { inherit pkgs; };
    password-store = import ./programs/password-store/default.nix;
    thunderbird = import ./programs/thunderbird/default.nix (chadConfig // { inherit pkgs; });
    tmux = import ./programs/tmux/default.nix;
    vscode = import ./programs/vscode/default.nix { inherit pkgs; };
    zsh = import ./programs/zsh/default.nix chadConfig;
  };
}
