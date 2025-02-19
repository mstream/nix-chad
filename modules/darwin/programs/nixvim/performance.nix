{
  programs.nixvim.performance = {
    byteCompileLua = {
      configs = true;
      enable = true;
      initLua = true;
      nvimRuntime = true;
      plugins = false;
    };
    combinePlugins = {
      enable = false;
    };
  };
}
