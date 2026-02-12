{ chadLib, config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  foldModeSpecificKeymaps = chadLib.attrsets.foldlAttrs (
    acc: mode: keymaps:
    acc
    ++ (chadLib.attrsets.mapAttrsToList (key: action: {
      inherit action key;
      mode = chadLib.constants.nvim.modes.mapTo.id mode;
    }) keymaps)
  ) [ ];
in
{
  programs.nixvim.keymaps = foldModeSpecificKeymaps (
    with chadLib.constants.nvim.modes.members;
    {
      ${command} = { };
      ${insert} = { };
      ${normal} = {
        "${kms.uncategorized.cancel}" = ":nohlsearch<CR>";
        "${kms.uncategorized.moveToBottomWindow}" = "<C-w>j";
        "${kms.uncategorized.moveToLeftWindow}" = "<C-w>h";
        "${kms.uncategorized.moveToRightWindow}" = "<C-w>l";
        "${kms.uncategorized.moveToTopWindow}" = "<C-w>k";
        #"${kms.uncategorized.scrollDown}" = "<C-d>zz";
        #"${kms.uncategorized.scrollUp}" = "<C-u>zz";
        "${kms.categorized.close.suffixes.currentBuffer}" =
          "<Cmd>BufferClose<CR>";
        "${kms.categorized.refactor.suffixes.action}" =
          ":lua vim.lsp.buf.code_action()<CR>";
      };
      ${visual} = { };
    }
  );
}
