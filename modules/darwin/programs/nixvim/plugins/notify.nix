{
  programs.nixvim.plugins.notify = {
    enable = true;
    settings = {
      background_colour = null;
      fps = 10;
      level = "info";
      max_height = null;
      max_width = null;
      minimum_width = 50;
      render = "wrapped-compact";
      stages = "slide";
      timeout = 5000;
      top_down = true;
    };
  };
}
