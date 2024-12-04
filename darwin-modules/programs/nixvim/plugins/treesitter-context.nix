{
  programs.nixvim.plugins.treesitter-context = {
    enable = true;
    settings = {
      line_numbers = true;
      max_lines = 0;
      min_window_height = 0;
      mode = "cursor";
      multiline_threshold = 20;
      zindex = 20;
    };
  };
}
