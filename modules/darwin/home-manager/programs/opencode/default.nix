_: {
  programs.opencode = {
    enable = true;
    settings = {
      autoshare = false;
      autoupdate = false;
      model = "google/gemini-3-flash-preview";
      permission = {
        bash = "ask";
        edit = "ask";
        glob = "ask";
        grep = "ask";
        list = "ask";
        lsp = "ask";
        patch = "ask";
        skill = "ask";
        read = "ask";
        todoread = "ask";
        todowrite = "ask";
        webfetch = "ask";
        write = "ask";
      };
      plugin = [ "opencode-gemini-auth@v1.3.8" ];
      /*
        provider = {
          google = {
            models = {
              "gemini-3-flash-preview" = {
                options = {
                  thinkingConfig = {
                    thinkingLevel = "high";
                    includeThoughts = true;
                  };
                };
              };
            };
          };
        };
      */
      theme = "gruvbox";
      tui = {
        diff_style = "stacked";
        scroll_acceleration = {
          enabled = true;
        };
        scroll_speed = 3;
      };
    };
  };
}
