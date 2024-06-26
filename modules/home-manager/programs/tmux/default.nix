_: {
  programs.tmux = {
    baseIndex = 1;
    clock24 = true;
    enable = false;
    extraConfig = ''
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      set -g focus-events on
      set -s escape-time 0
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ",*:RGB"
    '';
    historyLimit = 5000;
    keyMode = "vi";
    prefix = "'C-Space'";
    sensibleOnTop = false;
  };
}
