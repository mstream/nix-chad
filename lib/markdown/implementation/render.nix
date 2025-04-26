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

  renderAnyNode =
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

  renderFlowContentNodes =
    lineBreakIndentation:
    (
      with chadLib.yants;
      defun [
        (list validators.flowContentNode)
        string
      ]
    )
      (
        nodes:
        let
          renderNode = renderAnyNode lineBreakIndentation;
          renderSep =
            previousNode: currentNode:
            if previousNode == null then
              ""
            else if currentNode.nodeType == nodeTypes.members.heading then
              "${lineBreakIndentation}${lineBreakIndentation}"
            else if previousNode.nodeType == nodeTypes.members.heading then
              "${lineBreakIndentation}${lineBreakIndentation}"
            else
              lineBreakIndentation;
        in
        (chadLib.core.foldl'
          (
            acc: node:
            let
              nodeRep = renderNode node;
              sep = renderSep acc.previousNode node;
            in
            {
              nodesRep = "${acc.nodesRep}${sep}${nodeRep}";
              previousNode = node;
            }
          )
          {
            nodesRep = "";
            previousNode = null;
          }
          nodes
        ).nodesRep
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
          renderItem = renderAnyNode (
            incrementIndentation lineBreakIndentation prefix
          );
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
          renderChild = renderAnyNode lineBreakIndentation;
        in
        chadLib.strings.concatMapStringsSep lineBreakIndentation renderChild
          children;
      paragraph =
        { children, ... }:
        let
          renderChild = renderAnyNode lineBreakIndentation;
        in
        chadLib.strings.concatMapStrings renderChild children;
      text = { value, ... }: value;
      thematicBreak =
        _:
        let
          threeDashes = "---";
        in
        threeDashes;
    });
in
chadLib.functions.compose [
  (renderFlowContentNodes "\n")
  (s: "${s}\n")
]
