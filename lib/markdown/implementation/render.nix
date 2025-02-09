{
  chadLib,
  nodeTypes,
  validators,
  ...
}:
let
  incrementIndentation =
    lineBreakIndentation: parentPrefix:
    let
      alignment = chadLib.strings.stringAsChars (chadLib.functions.constant " ") parentPrefix;
    in
    "${lineBreakIndentation}${alignment}";

  render =
    lineBreakIndentation:
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
          renderNode = nodeTypes.mapWith (renderers lineBreakIndentation) node.nodeType;
        in
        renderNode node
      );

  renderers =
    lineBreakIndentation:
    chadLib.fixedPoints.fix (self: {
      heading =
        { depth, text, ... }:
        let
          prefix = chadLib.strings.concatMapStrings (chadLib.functions.constant "#") (
            chadLib.lists.range 1 depth
          );
        in
        "${prefix} ${text}";
      lineBreak =
        _:
        let
          twoSpaces = "  ";
        in
        "${twoSpaces}${lineBreakIndentation}";
      link = { text, url, ... }: "[${text}](${url})";
      list =
        { items, ordered, ... }:
        let
          prefix = if ordered then "1. " else "- ";
          renderItem = render (incrementIndentation lineBreakIndentation prefix);
        in
        chadLib.strings.concatMapStringsSep lineBreakIndentation (
          chadLib.functions.compose
          [
            renderItem
            (s: "${prefix}${s}")
          ]
        ) items;
      listItem =
        { children, ... }:
        let
          renderChild = render lineBreakIndentation;
        in
        chadLib.strings.concatMapStringsSep lineBreakIndentation renderChild
          children;
      paragraph =
        { children, ... }:
        let
          renderChild = render lineBreakIndentation;
        in
        chadLib.strings.concatMapStrings renderChild children;
      text = { value, ... }: value;
    });
in
chadLib.functions.compose [
  (render "\n")
  (s: "${s}\n")
]
