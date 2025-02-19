{
  chadLib,
  nodeTypes,
  validators,
  ...
}:
let
  withValidation = chadLib.core.mapAttrs (
    name: f:
    if name == "lineBreak" || name == "thematicBreak" then
      f
    else
      validators.nodeCreatingFunctions.${name} f
  );
in
withValidation {
  heading =
    {
      depth,
      text,
    }:
    {
      inherit depth text;
      nodeType = nodeTypes.members.heading;
    };
  lineBreak = {
    nodeType = nodeTypes.members.lineBreak;
  };
  link =
    {
      text,
      url,
    }:
    {
      inherit text url;
      nodeType = nodeTypes.members.link;
    };
  list =
    {
      items,
      ordered ? false,
    }:
    {
      inherit items ordered;
      nodeType = nodeTypes.members.list;
    };
  listItem = children: {
    inherit children;
    nodeType = nodeTypes.members.listItem;
  };
  paragraph = children: {
    inherit children;
    nodeType = nodeTypes.members.paragraph;
  };
  text = value: {
    inherit value;
    nodeType = nodeTypes.members.text;
  };
  thematicBreak = {
    nodeType = nodeTypes.members.thematicBreak;
  };
}
