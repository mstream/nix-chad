{ fontSize, ... }:
let family = "JetbrainsMono Nerd Font";
in {
  enable = true;
  settings = {
    font = {
      size = fontSize;
      normal.family = family;
      normal.style = "Medium";
      bold.family = family;
      bold.style = "Bold";
      italic.family = family;
      italic.style = "Italic";
    };
    key_bindings = [ ];
    shell = {
      program = "zsh";
      args = [ "-l" "-c" "zellij attach --index 0 || zellij" ];
    };
    window = {
      blur = true;
      decorations = "full";
      dynamic_padding = true;
      dynamic_title = true;
      opacity = 0.9;
      option_as_alt = "Both";
      scrolling = { history = 0; };
      startup_mode = "Windowed";
    };
  };
}
