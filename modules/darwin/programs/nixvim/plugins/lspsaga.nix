{
  programs.nixvim.plugins.lspsaga = {
    enable = false;
    settings = {
      beacon = {
        enable = true;
        frequency = 7;
      };
      lightbulb = {
        debounce = 10;
        enable = true;
        sign = true;
        sign_priority = 40;
        virtual_text = true;
      };
    };
  };
}
