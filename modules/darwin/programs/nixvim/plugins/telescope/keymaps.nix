{
  chadLib,
  kms,
  pickers,
  ...
}:
chadLib.attrsets.generate
  [
    "codeDefinitions"
    "codeImplementations"
    "codeReferences"
    "codeTypeDefinitions"
    "gitBranches"
    "gitCommits"
    "gitLocalChanges"
    "gitStash"
    "files"
    "vimBuffers"
    "vimCommands"
    "vimHelp"
    "words"
  ]
  (
    findTargetName:
    let
      keySequence = kms.categorized.find.suffixes.${findTargetName};
      pickerId = pickers.mapTo.id pickers.members.${findTargetName};
    in
    {
      ${keySequence} = pickerId;
    }
  )
