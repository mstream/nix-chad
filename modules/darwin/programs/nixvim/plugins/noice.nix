let
  baseThrottle = 100;
in
{
  programs.nixvim.plugins.noice = {
    enable = true;
    format = { };
    settings = {
      health = {
        checker = true;
      };
      lsp = {
        hover = {
          enabled = true;
          opts = { };
          view = null;
        };
        message = {
          enabled = true;
          opts = { };
          view = "notify";
        };
        progress = {
          enabled = true;
          format = "lsp_progress";
          format_done = "lsp_progress_done";
          throttle = baseThrottle;
        };
        signature = {
          auto_open = {
            enabled = true;
            luasnip = true;
            throttle = 2 * baseThrottle;
            trugger = true;
          };
          enabled = true;
          opts = { };
          view = null;
        };
      };
      messages = {
        enable = true;
        view = "notify";
        view_history = "messages";
        view_search = "notify";
        view_warn = "notify";
      };
      notify = {
        enabled = true;
        view = "notify";
      };
      popupmenu = {
        backend = "nui";
        enabled = true;
        kindIcons = { };
      };
      smart_move = {
        enabled = true;
        excluded_filetypes = [ ];
      };
      throttle = baseThrottle;
    };
  };
}
