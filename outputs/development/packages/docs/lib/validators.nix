{ chadLib, ... }:
with chadLib.yants;
rec {
  keymaps = struct "keymaps" {
    categorized = categorizedKeymaps;
    uncategorized = list sequenceEntry;
  };
  keymapsAst = defun [
    keymaps
    (list (attrs any))
  ];
  categorizedKeymaps = attrs (list sequenceEntry);
  neovimCategoryMappings = attrs neovimPrefixEntry;
  neovimOtherMappings = attrs string;
  uncategorizedKeymaps = list sequenceEntry;
  neovimPrefixEntry = struct "neovimPrefixEntry" {
    prefix = string;
    suffixes = attrs string;
  };
  sequenceEntry = struct "sequenceEntry" {
    description = string;
    sequence = string;
  };
  zellijModalGroupEntry = struct "zellijModalGroupEntry" {
    description = string;
    entries = attrs string;
  };
  zellijModalMappings = attrs zellijModalGroupEntry;
  zellijSharedMappings = attrs string;
}
