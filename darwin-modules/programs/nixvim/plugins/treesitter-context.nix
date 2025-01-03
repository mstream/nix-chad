{
  programs.nixvim.plugins.treesitter-context = {
    enable = true;
    settings = {
      line_numbers = true;
      max_lines = 5;
      min_window_height = 10;
      mode = "topline";
      multiline_threshold = 20;
      multiwindow = false;
      trim_scope = "outer";
      zindex = 20;
    };
  };
}
