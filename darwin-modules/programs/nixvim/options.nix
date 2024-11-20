{ config, ... }:
let
  cfg = config.chad;
  isNumberingRelative = cfg.editor.lineNumbering == "relative";
  documentWidth = cfg.editor.documentWidth;
  tabWidth = cfg.editor.tabWidth;
  colorColumn = documentWidth + 1;
in
{
  programs.nixvim.opts = {
    colorcolumn = builtins.toString colorColumn;
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
    relativenumber = isNumberingRelative;
    ruler = false;
    scrolloff = 8;
    shiftwidth = tabWidth;
    showmode = false;
    signcolumn = "auto";
    smartcase = true;
    smartindent = true;
    spell = false;
    swapfile = true;
    tabstop = tabWidth;
    termguicolors = true;
    undofile = true;
    updatetime = 100;
    wrap = false;
  };
}
