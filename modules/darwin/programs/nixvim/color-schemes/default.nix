{
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    settings = {
      dim_inactive = {
        enabled = true;
        percentage = 0.1;
        shade = "dark";
      };
      disable_underline = true;
      flavour = "mocha";
      integrations = import ./integrations.nix;
      kitty = true;
      show_end_of_buffer = true;
      styles = {
        booleans = [
          "bold"
          "italic"
        ];
        conditionals = [
          "bold"
        ];
      };
      term_colors = false;
      transparent_background = false;
    };
  };
}
