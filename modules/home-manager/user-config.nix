{ osConfig, pkgs, ... }:
let
  chadConfig = osConfig.chad;
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
    builtins.map (packageName: pkgs.${packageName}) chadConfig.extraPackages;
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
  } chadConfig.user.homeDirectories).result;

  gnupgDirectories = if chadConfig.gpg.defaultKey == null then
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
        ${chadConfig.gpg.defaultKey}
      '';
    };
  };

  homeFiles = pkgs.lib.recursiveUpdate gnupgDirectories userDefinedDirectories;
in {
  imports = [
    ./programs/alacritty/default.nix
    ./programs/bat/default.nix
    ./programs/direnv/default.nix
    ./programs/git/default.nix
    ./programs/gpg/default.nix
    ./programs/jq/default.nix
    ./programs/neovim/default.nix
    ./programs/password-store/default.nix
    ./programs/tmux/default.nix
    ./programs/vscode/default.nix
    ./programs/zellij/default.nix
    ./programs/zsh/default.nix
  ];

  home = {
    file = homeFiles;
    packages = nvimPackages ++ otherPackages ++ customPackages;
    stateVersion = "23.11";
  };
}
