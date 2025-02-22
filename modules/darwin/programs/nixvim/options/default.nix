{ chadLib, config, ... }:
let
  cfg = config.chad;
  inherit (cfg.editor) documentWidth tabWidth;
  isNumberingRelative = cfg.editor.lineNumbering == "relative";
  colorColumn = documentWidth + 1;
in
{
  programs.nixvim.opts = {
    colorcolumn = builtins.toString colorColumn;
    cursorline = true;
    cursorlineopt = "both";
    cursorcolumn = true;
    expandtab = true;
    fileencoding = "utf-8";
    foldlevel = 99;
    hidden = true;
    ignorecase = true;
    incsearch = true;
    laststatus = 3;
    list = true;
    listchars = import ./list-chars.nix { inherit chadLib; };
    number = true;
    relativenumber = isNumberingRelative;
    ruler = false;
    scrolloff = 99;
    shiftwidth = tabWidth;
    showmode = false;
    signcolumn = "yes";
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
