{ osConfig, ... }:
let
  cfg = osConfig.chad;
  fontConfig = style: {
    inherit style;
    family = "JetbrainsMono Nerd Font";
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = false;
        transparent_background_colors = false;
      };
      cursor = {
        style = {
          blinking = "Off";
          shape = "Block";
        };
        thickness = 0.15;
        unfocused_hollow = true;
      };
      debug = {
        log_level = "Warn";
        persistent_logging = false;
      };
      font = {
        bold = fontConfig "Bold";
        bold_italic = fontConfig "Bold Italic";
        builtin_box_drawing = true;
        glyph_offset = {
          x = 0;
          y = 0;
        };
        italic = fontConfig "Italic";
        normal = fontConfig "Medium";
        offset = {
          x = 0;
          y = 0;
        };
        size = cfg.fontSize;
      };
      general = {
        live_config_reload = true;
      };
      keyboard.bindings = cfg.terminal.keyBindings;
      scrolling = {
        history = 0;
        multiplier = 0;
      };
      terminal = {
        osc52 = "OnlyCopy";
        shell = {
          program = "zsh";
          args = [
            "-l"
            "-c"
            "zellij attach --index 0 || zellij"
          ];
        };
      };
      window = {
        blur = true;
        decorations_theme_variant = "Dark";
        decorations = "full";
        dynamic_padding = true;
        dynamic_title = true;
        opacity = 0.67;
        option_as_alt = "Both";
        resize_increments = true;
        startup_mode = "Windowed";
      };
    };
  };
}
