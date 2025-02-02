{
  chadLib,
  nodeTypes,
  ...
}:
with chadLib.yants;
rec {
  anyNode = eitherN [
    headingNode
    linkNode
    listNode
    paragraphNode
    textNode
  ];

  breakNode = struct "breakNode" {
    nodeType = nodeTypeOf nodeTypes.members.break;
  };

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
    chadLib.core.mapAttrs (chadLib.functions.constant defun)
      {
        break = [ breakNode ];
        heading = [
          (struct "headingNodeArgs" {
            inherit depth;
            text = string;
          })
          headingNode
        ];
        list = [
          (struct "listNodeArgs" {
            items = list flowContentNode;
            ordered = option bool;
          })
          listNode
        ];
        listItem = [
          (struct "listItemNodeArgs")
          {
            children = list flowContentNode;
          }
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
    linkNode
    textNode
  ];

  textNode = struct "textNode" {
    nodeType = nodeTypeOf nodeTypes.members.text;
    value = string;
  };
}
