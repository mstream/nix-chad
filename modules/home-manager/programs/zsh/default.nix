{ osConfig, ... }:
let
  cfg = osConfig.chad;
  userKeyMapping = (if cfg.keyboard.remapLeftArrow then [{
    HIDKeyboardModifierMappingSrc = 30064771152;
    HIDKeyboardModifierMappingDst = 30064771300;
  }] else
    [ ]) ++ (if cfg.keyboard.remapCapsLock then [{
      HIDKeyboardModifierMappingSrc = 30064771129;
      HIDKeyboardModifierMappingDst = 30064771113;
    }] else
      [ ]);
in {
  programs.zsh = {
    autocd = false;
    cdpath = [ ];
    completionInit = "autoload -U compinit && compinit";
    dirHashes = { };
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    envExtra = "";
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      save = 20000;
      share = true;
      size = 20000;
    };
    historySubstringSearch = { };
    initExtra = ''
      setopt ignore_eof
      unsetopt extended_glob
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      hidutil property --set '{"UserKeyMapping":${
        builtins.toJSON userKeyMapping
      }}' > /dev/null
      ${cfg.terminal.zshInitExtra}
      bindkey -M vicmd "^d" down-history 
      bindkey -M vicmd "^u" up-history 
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
      syntaxHighlighting = { styles = { comment = "fg=white"; }; };
      utility = { safeOps = true; };
    };
    profileExtra = "";
    sessionVariables = { };
    shellAliases = {
      la = "ls -a -l";
      ll = "ls -l";
    };
    shellGlobalAliases = { };
    syntaxHighlighting = { enable = true; };
  };
}
