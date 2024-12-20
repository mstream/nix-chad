{ pkgs, ... }:
{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    fromVscode = [
      {
        lazyLoad = true;
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }
    ];
    settings = {
      enable_autosnippets = true;
    };
  };
}
