{
  programs.nixvim.plugins.guess-indent = {
    enable = true;
    settings = {
      auto_cmd = true;
      on_tab_options = {
        "expandtab" = false;
      };
      on_space_options = {
        "expandtab" = true;
        "tabstop" = "detected";
        "softtabstop" = "detected";
        "shiftwidth" = "detected";
      };
      override_editorconfig = false;
    };
  };
}
