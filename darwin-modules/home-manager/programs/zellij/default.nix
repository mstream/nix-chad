{ lib, ... }:
let
  directions = lib.enum.create {
    memberNames = [
      "down"
      "left"
      "right"
      "up"
    ];
    name = "directions";
  };
  modes = lib.enum.create {
    mappings = {
      key = {
        enterSearch = "entersearch";
        locked = "locked";
        move = "move";
        normal = "normal";
        pane = "pane";
        renamePane = "renamepane";
        renameTab = "renametab";
        resize = "resize";
        scroll = "scroll";
        search = "search";
        session = "session";
        tab = "tab";
        tmux = "tmux";
      };
    };
    memberNames = [
      "enterSearch"
      "locked"
      "move"
      "normal"
      "pane"
      "renamePane"
      "renameTab"
      "resize"
      "scroll"
      "search"
      "session"
      "tab"
      "tmux"
    ];
    name = "modes";
  };
  keys = import ./keys.nix { inherit directions lib modes; };
  presets = import ./presets {
    inherit
      directions
      lib
      keys
      modes
      ;
  };
in
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    settings = presets.custom // {
      auto_layout = true;
      default_layout = "default";
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
