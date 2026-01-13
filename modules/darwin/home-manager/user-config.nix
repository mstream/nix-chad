{
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.chad;
  propertiaryPackages = [ ];
  otherPackages =
    with pkgs;
    [
      bat
      coreutils
      docker
      editorconfig-checker
      # this is a dependency for cmp-fuzzy-path neovim plugin
      fd
      gawk
      nmap
      node2nix
      nodejs
      # this is a dependency for cmp-rg neovim plugin
      ripgrep
      tldr
      tree
      unixtools.watch
    ]
    ++ (if cfg.software.openSourceOnly then [ ] else propertiaryPackages);
  customPackages =
    if cfg.extraPackages == null then [ ] else cfg.extraPackages pkgs;
  userDefinedDirectories =
    (builtins.foldl'
      (acc: dir: {
        idx = acc.idx + 1;
        result = acc.result // {
          "homeDirectory${builtins.toString acc.idx}" = {
            recursive = true;
            target = "${dir}/.keep";
            text = "";
          };
        };
      })
      {
        idx = 0;
        result = { };
      }
      cfg.user.homeDirectories
    ).result;

  gnupgDirectories =
    if cfg.gpg.defaultKey == null then
      { }
    else
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
            ${cfg.gpg.defaultKey}
          '';
        };
      };

  npmGlobalDirectoryPath = ".cache/npm/global";

  npmFiles = {
    ".npmrc" = {
      text = ''
        prefix=/Users/${cfg.user.name}/${npmGlobalDirectoryPath}
        registry=https://registry.npmjs.org/
      '';
    };
  };

  homeFiles =
    pkgs.lib.recursiveUpdate gnupgDirectories userDefinedDirectories
    // npmFiles;
in
{
  imports = [
    ./programs/alacritty
    ./programs/bat
    ./programs/codex
    ./programs/direnv
    ./programs/firefox
    ./programs/gemini-cli
    ./programs/git
    ./programs/gpg
    ./programs/jq
    ./programs/password-store
    ./programs/vscode
    ./programs/zellij
    ./programs/zsh
  ];

  config = {
    home = {
      enableNixpkgsReleaseCheck = true;
      file = homeFiles;
      packages = otherPackages ++ customPackages;
      sessionPath = [
        "$HOME/${npmGlobalDirectoryPath}/bin"
      ];
      sessionVariables = {
        DIRENV_WARN_TIMEOUT = "30s";
      };
      stateVersion = cfg.nixpkgsReleaseVersion;
    };
  };
}
