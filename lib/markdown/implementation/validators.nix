{
  chadLib,
  nodeTypes,
  ...
}:
with chadLib.yants;
rec {
  anyNode = eitherN [
    headingNode
    lineBreakNode
    linkNode
    listItemNode
    listNode
    paragraphNode
    textNode
  ];

  depth = restrict "depth" (i: i >= 1 && i <= 6) int;

  flowContentNode = eitherN [
    listNode
    paragraphNode
  ];

  headingNode = struct "headingNode" {
    inherit depth;
    nodeType = nodeTypeOf nodeTypes.members.heading;
    text = string;
  };

  lineBreakNode = struct "lineBreakNode" {
    nodeType = nodeTypeOf nodeTypes.members.lineBreak;
  };

  linkNode = struct "linkNode" {
    nodeType = nodeTypeOf nodeTypes.members.link;
    text = string;
    url = string;
  };

  listItemNode = struct "listItemNode" {
    children = list flowContentNode;
    nodeType = nodeTypeOf nodeTypes.members.listItem;
  };

  listNode = struct "listNode" {
    items = list listItemNode;
    nodeType = nodeTypeOf nodeTypes.members.list;
    ordered = bool;
  };

  nodeCreatingFunctions =
    chadLib.core.mapAttrs
      (name: f: if name == "lineBreak" then f else defun f)
      {
        heading = [
          (struct "headingNodeArgs" {
            inherit depth;
            text = string;
          })
          headingNode
        ];
        lineBreak = [ breakNode ];
        list = [
          (struct "listNodeArgs" {
            items = list listItemNode;
            ordered = option bool;
          })
          listNode
        ];
        listItem = [
          (list flowContentNode)
          listItemNode
        ];
        link = [
          (struct "linkNodeArgs" {
            text = string;
            url = string;
          })
          linkNode
        ];
        paragraph = [
          (list phrasingContentNode)
          paragraphNode
        ];
        text = [
          string
          textNode
        ];
      };

  nodeTypeOf =
    nodeTypeMember:
    restrict "nodeType:${nodeTypeMember}" (s: s == nodeTypeMember) string;

  paragraphNode = struct "paragraphNode" {
    children = list phrasingContentNode;
    nodeType = nodeTypeOf nodeTypes.members.paragraph;
  };

  phrasingContentNode = eitherN [
    lineBreakNode
    linkNode
    textNode
  ];

  textNode = struct "textNode" {
    nodeType = nodeTypeOf nodeTypes.members.text;
    value = string;
  };
}
