{ zshInitExtra, ... }: {
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
