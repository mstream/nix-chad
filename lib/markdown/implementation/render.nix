{
  chadLib,
  nodeTypes,
  validators,
  ...
}:
let
  render =
    lineBreak:
    (
      with chadLib.yants;
      defun [
        validators.anyNode
        string
      ]
    )
      (
        node:
        let
          renderNode = nodeTypes.mapWith (renderers lineBreak) node.nodeType;
        in
        renderNode node
      );

  renderers =
    lineBreak:
    chadLib.fixedPoints.fix (self: {
      break =
        _:
        let
          twoSpaces = "  ";
        in
        "${twoSpaces}${lineBreak}";
      heading =
        { depth, text, ... }:
        let
          prefix = chadLib.strings.concatMapStrings (chadLib.functions.constant "#") (
            chadLib.lists.range 1 depth
          );
        in
        "${prefix} ${text}";
      link = { text, url, ... }: "[${text}](${url})";
      list =
        { items, ordered, ... }:
        let
          prefix = if ordered then "1." else "-";
          itemsIndentation = chadLib.strings.stringAsChars (chadLib.functions.constant " ") prefix;
          renderItem = render (lineBreak + itemsIndentation);
        in
        chadLib.strings.concatMapStringsSep lineBreak (chadLib.functions.compose
          [
            renderItem
            (s: "${prefix} ${s}")
          ]
        ) items;
      listItem =
        { children, ... }:
        let
          renderChild = render lineBreak;
        in
        chadLib.strings.concatMapStrings renderChild children;
      paragraph =
        { children, ... }:
        let
          renderChild = render lineBreak;
        in
        chadLib.strings.concatMapStrings renderChild children;
      text = { value, ... }: value;
    });
in
render "\n"
