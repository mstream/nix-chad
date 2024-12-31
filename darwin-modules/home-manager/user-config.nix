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

  homeFiles = pkgs.lib.recursiveUpdate gnupgDirectories userDefinedDirectories;
in
{
  imports = [
    ./programs/alacritty/default.nix
    ./programs/bat/default.nix
    ./programs/direnv/default.nix
    ./programs/firefox/default.nix
    ./programs/git/default.nix
    ./programs/gpg/default.nix
    ./programs/jq/default.nix
    ./programs/password-store/default.nix
    ./programs/vscode/default.nix
    ./programs/zellij/default.nix
    ./programs/zsh/default.nix
  ];

  config = {
    home = {
      enableNixpkgsReleaseCheck = true;
      file = homeFiles;
      packages = otherPackages ++ customPackages;
      sessionVariables = {
        DIRENV_WARN_TIMEOUT = "30s";
      };
      stateVersion = cfg.nixpkgsReleaseVersion;
    };
  };
}
