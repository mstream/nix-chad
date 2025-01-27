{ chadLib, config, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;

  modes = chadLib.enum.create {
    mappings = {
      id = {
        command = "c";
        insert = "i";
        normal = "n";
        visual = "v";
      };
    };
    memberNames = [
      "command"
      "insert"
      "normal"
      "visual"
    ];
    name = "vimModes";
  };

  foldModeSpecificKeymaps = chadLib.attrsets.foldlAttrs (
    acc: mode: keymaps:
    let
      keymapsWithArrowKeysDisabled = chadLib.attrsets.merge keymaps {
        "<Down>" = "<NOP>";
        "<Left>" = "<NOP>";
        "<Right>" = "<NOP>";
        "<Up>" = "<NOP>";
      };
    in
    acc
    ++ (chadLib.attrsets.mapAttrsToList (key: action: {
      inherit action key;
      mode = modes.mapTo.id mode;
    }) keymapsWithArrowKeysDisabled)
  ) [ ];
in
{
  programs.nixvim.keymaps = foldModeSpecificKeymaps (
    with modes.members;
    {
      ${command} = { };
      ${insert} = { };
      ${normal} = {
        "${kms.uncategorized.cancel}" = ":nohlsearch<CR>";
        "${kms.uncategorized.moveToBottomWindow}" = "<C-w>j";
        "${kms.uncategorized.moveToLeftWindow}" = "<C-w>h";
        "${kms.uncategorized.moveToRightWindow}" = "<C-w>l";
        "${kms.uncategorized.moveToTopWindow}" = "<C-w>k";
        "${kms.uncategorized.scrollDown}" = "<C-d>zz";
        "${kms.uncategorized.scrollUp}" = "<C-u>zz";
        "${kms.categorized.close.suffixes.currentBuffer}" =
          "<Cmd>BufferClose<CR>";
        "${kms.categorized.refactor.suffixes.action}" =
          ":lua vim.lsp.buf.code_action()<CR>";
      };
      ${visual} = { };
    }
  );
}
