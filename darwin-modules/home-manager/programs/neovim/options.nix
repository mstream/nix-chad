{ osConfig, ... }:
let
  cfg = osConfig.chad;
  isNumberingRelative = cfg.editor.lineNumbering == "relative";
  documentWidth = cfg.editor.documentWidth;
  tabWidth = cfg.editor.tabWidth;
in
{
  programs.nixvim.opts = {
    colorcolumn = documentWidth + 1;
    cursorline = true;
    cursorlineopt = "number";
    cursorcolumn = true;
    expandtab = true;
    fileencoding = "utf-8";
    foldlevel = 99;
    hidden = true;
    ignorecase = true;
    incsearch = true;
    laststatus = 3;
    number = true;
    numberWidth = 3;
    relativenumber = isNumberingRelative;
    ruler = false;
    scrolloff = 8;
    shiftwidth = tabWidth;
    showmode = false;
    signcolumn = true;
    smartcase = true;
    smartindent = true;
    softtabsstop = tabWidth;
    spell = false;
    swapfile = true;
    tabstop = tabWidth;
    termguicolors = true;
    undofile = true;
    updatetime = 100;
    wrap = false;
  };
}
