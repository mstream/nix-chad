{
  programs.nixvim.plugins.hardtime = {
    enable = true;
    settings = {
      allow_different_key = false;
      disable_mouse = true;
      disabled_filetypes = [ ];
      hint = true;
      max_count = 2;
      max_time = 1000;
      notification = true;
      restriction_mode = "block";
    };
  };
}
