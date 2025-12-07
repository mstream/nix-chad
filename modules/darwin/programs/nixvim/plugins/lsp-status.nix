_: {
  programs.nixvim.plugins.lsp-status = {
    enable = true;
    settings = {
      component_separator = " ";
      current_function = true;
      diagnostics = true;
      show_filename = true;
      update_interval = 500;
    };
  };
}
