{ pkgs, version, ... }:
chadConfig@{ defaultGpgKey, extraPackages, homeDirectories, ... }:
let
  nvimPackages = pkgs.callPackage ./programs/neovim/dependencies.nix { };
  otherPackages = with pkgs; [
    bat
    coreutils
    editorconfig-checker
    gawk
    jetbrains.idea-ultimate
    nmap
    nodePackages.node2nix
    tree
    unixtools.watch
  ];
  customPackages =
    builtins.map (packageName: pkgs.${packageName}) extraPackages;
  userDefinedDirectories = (builtins.foldl' (acc: dir: {
    idx = acc.idx + 1;
    result = acc.result // {
      "homeDirectory${builtins.toString acc.idx}" = {
        recursive = true;
        target = "${dir}/.keep";
        text = "";
      };
    };
  }) {
    idx = 0;
    result = { };
  } homeDirectories).result;

  gnupgDirectories = if defaultGpgKey == null then
    { }
  else {
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

  homeFiles = pkgs.lib.recursiveUpdate gnupgDirectories userDefinedDirectories;
in {
  home = {
    file = homeFiles;
    packages = nvimPackages ++ otherPackages ++ customPackages;
    stateVersion = version;
  };

  programs = {
    alacritty = import ./programs/alacritty/default.nix chadConfig;
    bat = import ./programs/bat/default.nix;
    browserpass = import ./programs/browserpass/default.nix;
    chromium = import ./programs/chromium/default.nix { inherit pkgs; };
    direnv = import ./programs/direnv/default.nix;
    firefox =
      import ./programs/firefox/default.nix (chadConfig // { inherit pkgs; });
    git = import ./programs/git/default.nix chadConfig;
    gpg = import ./programs/gpg/default.nix chadConfig;
    jq = import ./programs/jq/default.nix;
    neovim = import ./programs/neovim/default.nix { inherit pkgs; };
    password-store = import ./programs/password-store/default.nix;
    qutebrowser = import ./programs/qutebrowser/default.nix chadConfig;
    thunderbird = import ./programs/thunderbird/default.nix
      (chadConfig // { inherit pkgs; });
    tmux = import ./programs/tmux/default.nix;
    vscode = import ./programs/vscode/default.nix { inherit pkgs; };
    zellij = import ./programs/zellij/default.nix;
    zsh = import ./programs/zsh/default.nix chadConfig;
  };
}
