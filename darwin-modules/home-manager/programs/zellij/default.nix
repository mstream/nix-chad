{ pkgs, yants, ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    settings = {
      auto_layout = true;
      default_layout = "default";
      default_mode = "normal";
      keybinds = import ./keybinds { inherit pkgs yants; };
      mouse_mode = false;
      on_force_close = "quit";
      scroll_buffer_size = 20000;
      simplified_ui = false;
      theme = "gruvbox";
      themes = import ./themes.nix;
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
  };
}
