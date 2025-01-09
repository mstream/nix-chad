{ chadLib, osConfig, ... }:
let
  inherit (import ./abbreviations.nix { inherit chadLib; })
    defaultAbbreviations
    mergeAbbreviations
    ;

  cfg = osConfig.chad;

  capsLockRemap = {
    HIDKeyboardModifierMappingSrc = 30064771129;
    HIDKeyboardModifierMappingDst = 30064771113;
  };

  leftArrowRemap = {
    HIDKeyboardModifierMappingSrc = 30064771152;
    HIDKeyboardModifierMappingDst = 30064771300;
  };

  userKeyMapping =
    (if cfg.keyboard.remapLeftArrow then [ leftArrowRemap ] else [ ])
    ++ (if cfg.keyboard.remapCapsLock then [ capsLockRemap ] else [ ]);

  abbreviations = mergeAbbreviations [
    defaultAbbreviations
    cfg.terminal.abbreviations.extraAbbreviations
  ];

  defaultEnvText = builtins.readFile ./default-env.zsh;
  defaultInitText = builtins.readFile ./default-init.zsh;
in
{
  programs.zsh = {
    autocd = false;
    autosuggestion = {
      enable = true;
    };
    cdpath = [ ];
    completionInit = "autoload -U compinit && compinit";
    dirHashes = { };
    enable = true;
    enableCompletion = true;
    envExtra = ''
      ${defaultEnvText}
    '';
    history = {
      append = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 20000;
      share = true;
      size = 20000;
    };
    historySubstringSearch = { };
    initExtra = ''
      ${defaultInitText}
      hidutil property --set '{"UserKeyMapping":${builtins.toJSON userKeyMapping}}' > /dev/null
      ${cfg.terminal.zshInitExtra}
    '';
    initExtraBeforeCompInit = "";
    initExtraFirst = "";
    localVariables = { };
    loginExtra = "";
    logoutExtra = "";
    oh-my-zsh = { };
    plugins = [ ];
    prezto = {
      autosuggestions.color = "fg=blue";
      caseSensitive = true;
      color = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
        promptContext = true;
      };
      enable = true;
      extraConfig = "";
      extraFunctions = [ ];
      extraModules = [ ];
      historySubstring = {
        foundColor = "fg=blue";
        notFoundColor = "fg=red";
      };
      pmodules = [
        "environment"
        "homebrew"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "osx"
        "archive"
        "completion"
        "fasd"
        "gpg"
        "prompt"
        "syntax-highlighting"
        "history-substring-search"
        "autosuggestions"
        "ssh"
        "command-not-found"
        "git"
        "node"
        "docker"
      ];
      prompt = {
        pwdLength = "short";
        theme = "sorin";
      };
      syntaxHighlighting = {
        styles = {
          comment = "fg=white";
        };
      };
      utility = {
        safeOps = true;
      };
    };
    profileExtra = "";
    sessionVariables = { };
    shellAliases =
      if cfg.terminal.abbreviations.enable then abbreviations else { };
    shellGlobalAliases = { };
    syntaxHighlighting = {
      enable = true;
    };
    zsh-abbr = {
      inherit abbreviations;
      enable =
        cfg.terminal.abbreviations.enable && !cfg.software.openSourceOnly;
    };
  };
}
