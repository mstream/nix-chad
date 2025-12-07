{
  programs.nixvim.plugins.nvim-lightbulb = {
    enable = false;
    settings = {
      action_kinds = null;
      autocmd.enabled = true;
      float.enabled = true;
      hide_in_unfocused_buffer = true;
      line.enabled = false;
      link_highlights = true;
      number.enabled = false;
      sign.enabled = false;
      status_text.enabled = false;
      validate_config = "always";
      virtual_text.enabled = false;
    };
  };
}
