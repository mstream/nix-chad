{ config, lib, ... }:
let
  cfg = config.chad;
  inherit (cfg.editor) documentWidth tabWidth;
  isNumberingRelative = cfg.editor.lineNumbering == "relative";
  colorColumn = documentWidth + 1;
  showNonPrintableCharacterSymbolsMapping = lib.function.compose [
    (lib.attrsets.mapAttrsToList (name: symbol: "${name}:${symbol}"))
    (lib.strings.concatStringsSep ",")
  ];

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
    list = true;
    listchars = showNonPrintableCharacterSymbolsMapping {
      conceal = "⚿";
      eol = "↵";
      extends = "»";
      precedes = "«";
      space = "␣";
      tab = "——⇥";
    };
    number = true;
    relativenumber = isNumberingRelative;
    ruler = false;
    scrolloff = 99;
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
