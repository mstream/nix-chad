{ lib, ... }:
let
  actions = lib.enum.create {
    memberNames = [
      "closeFocus"
      "closeTab"
      "goToTab"
      "halfPageScrollDown"
      "halfPageScrollUp"
      "moveFocusOrTab"
      "newPane"
      "newTab"
      "search"
      "searchInput"
      "searchToggleOption"
      "switchToMode"
      "toggleFocusFullScreen"
      "togglePaneFrames"
      "toggleTab"
    ];
    name = "actions";
  };
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
  modeGroups = lib.enum.create {
    mappings = {
      key = {
        sharedAmong = "shared_among";
        sharedExcept = "shared_except";
      };
    };
    memberNames = [
      "sharedAmong"
      "sharedExcept"
    ];
    name = "modeGroups";
  };
  searchOptions = lib.enum.create {
    memberNames = [
      "caseSensitivity"
    ];
    name = "searchOptions";
  };
  keys = import ./keys.nix {
    inherit
      actions
      directions
      lib
      modes
      modeGroups
      searchOptions
      ;
  };
  presets = import ./presets {
    inherit
      directions
      lib
      keys
      modes
      searchOptions
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
      disable_session_metadata = false;
      mirror_session = false;
      mouse_mode = false;
      on_force_close = "quit";
      scroll_buffer_size = 20000;
      serialize_pane_viewport = false;
      session_serialization = true;
      simplified_ui = false;
      theme = "gruvbox";
      themes = import ./themes.nix;
      styled_underlines = true;
      support_kitty_keyboard_protocol = true;
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
