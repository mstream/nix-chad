{
  baseIndex = 1;
  clock24 = true;
  enable = true;
  extraConfig = ''
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    set -s escape-time 0
    set-option -g default-terminal "screen-256color"
  '';
  historyLimit = 5000;
  keyMode = "vi";
  prefix = "'C-Space'";
}
