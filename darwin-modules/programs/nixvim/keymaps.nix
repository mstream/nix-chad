{ config, lib, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  modes = {
    command = "c";
    insert = "i";
    l = "l";
    normal = "n";
    o = "o";
    s = "s";
    t = "t";
    visual = "v";
    x = "x";
  };

  disabledKeys = {
    "<Down>" = "<NOP>";
    "<Left>" = "<NOP>";
    "<Right>" = "<NOP>";
    "<Up>" = "<NOP>";
  };

  keymapEntries =
    mode: attrs:
    lib.mapAttrsToList (key: action: { inherit action key mode; }) (
      attrs // disabledKeys
    );

  commandKeymaps = keymapEntries modes.command { };

  insertKeymaps = keymapEntries modes.insert { };

  normalKeymaps = keymapEntries modes.normal {
    "${kms.topLevel.cancel.combination}" = ":nohlsearch<CR>";
    "${kms.topLevel.moveToBottomWindow.combination}" = "<C-w>j";
    "${kms.topLevel.moveToLeftWindow.combination}" = "<C-w>h";
    "${kms.topLevel.moveToRightWindow.combination}" = "<C-w>l";
    "${kms.topLevel.moveToTopWindow.combination}" = "<C-w>k";
    "${kms.topLevel.scrollDown.combination}" = "<C-d>zz";
    "${kms.topLevel.scrollUp.combination}" = "<C-u>zz";
    "<leader>r ${kms.refactor.action.combination}" =
      "vim.lsp.buf.code_action()";
  };

  visualKeymaps = keymapEntries modes.visual { };
in
{
  programs.nixvim.keymaps =
    commandKeymaps ++ insertKeymaps ++ normalKeymaps ++ visualKeymaps;
}
