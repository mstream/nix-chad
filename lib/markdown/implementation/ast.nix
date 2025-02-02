{
  chadLib,
  nodeTypes,
  validators,
  ...
}:
let
  withValidation = chadLib.core.mapAttrs (
    functionName: validators.nodeCreatingFunctions.${functionName}
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
}
