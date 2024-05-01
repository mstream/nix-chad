let
  arrowKeys = [ "Down" "Left" "Right" "Up" ];
  keybinds = {
    "entersearch" = { };
    "locked" = { };
    "move" = { };
    "normal" = { unbind = builtins.map (k: "Alt ${k}") arrowKeys; };
    "pane" = { };
    "renamepane" = { };
    "renametab" = { };
    "resize" = { };
    "scroll" = { };
    "search" = { };
    "session" = { };
    "tmux" = { };
    "tab" = { };
    "shared_except \"locked\"" = { unbind = [ "Ctrl q" ]; };
    "shared_except \"locked\" \"move\"" = {
      bind = {
        _args = [ "Ctrl m" ];
        SwitchToMode = "move";
      };
      unbind = [ "Ctrl h" ];
    };
    "shared_except \"locked\" \"normal\"" = { };
    "shared_except \"locked\" \"pane\"" = { };
    "shared_except \"locked\" \"resize\"" = {
      bind = {
        _args = [ "Ctrl r" ];
        SwitchToMode = "resize";
      };
      unbind = [ "Ctrl n" ] ++ arrowKeys;
    };
    "shared_except \"locked\" \"scroll\"" = { };
    "shared_except \"locked\" \"session\"" = { };
    "shared_except \"locked\" \"tab\"" = { };
    "shared_except \"locked\" \"tmux\"" = { unbind = [ "Ctrl b" ]; };
  };
  themes = {
    gruvbox = {
      fg = "#D5C4A1";
      bg = "#282828";
      black = "#3C3836";
      red = "#CC241D";
      green = "#98971A";
      yellow = "#D79921";
      blue = "#3C8588";
      magenta = "#B16286";
      cyan = "#689D6A";
      white = "#FBF1C7";
      orange = "#D65D0E";
    };
  };
in {
  enable = true;
  enableBashIntegration = false;
  enableFishIntegration = false;
  enableZshIntegration = false;
  settings = {
    inherit keybinds themes;
    auto_layout = true;
    mouse_mode = false;
    scroll_buffer_size = 10000;
    theme = "gruvbox";
    styled_underlines = true;
    ui = {
      pane_frames = {
        hide_session_name = true;
        rounded_corners = true;
      };
    };
    window = {
      default_shell = "zsh";
      option_as_alt = "Both";
    };
  };
}

