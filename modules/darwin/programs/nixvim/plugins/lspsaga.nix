{
  programs.nixvim.plugins.lspsaga = {
    beacon = {
      enable = true;
      frequency = 7;
    };
    enable = false;
    lightbulb = {
      debounce = 10;
      enable = true;
      sign = true;
      signPriority = 40;
      virtualText = true;
    };
    scrollPreview = {

    };
  };
}
