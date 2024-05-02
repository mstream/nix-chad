{ remapCapsLock, remapLeftArrow, zshInitExtra, ... }:
let
  userKeyMapping = (if remapLeftArrow then [{
    HIDKeyboardModifierMappingSrc = 30064771152;
    HIDKeyboardModifierMappingDst = 30064771300;
  }] else
    [ ]) ++ (if remapCapsLock then [{
      HIDKeyboardModifierMappingSrc = 30064771129;
      HIDKeyboardModifierMappingDst = 30064771113;
    }] else
      [ ]);
in {
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
        unsetopt extended_glob
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        gpgconf --launch gpg-agent
        hidutil property --set '{"UserKeyMapping":${
          builtins.toJSON userKeyMapping
        }}' > /dev/null
    <<<<<<< HEAD
        hidutil property --set '{"UserKeyMapping":${
          builtins.toJSON userKeyMapping
        }}' > /dev/null
    =======
    >>>>>>> 1f1e77b (add option of switching off windows management)
        ${zshInitExtra}
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
}
