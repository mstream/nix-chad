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
  _raw = blob: {
    inherit blob;
    nodeType = nodeTypes.members.raw;
  };
  array = elements: {
    inherit elements;
    nodeType = nodeTypes.members.array;
  };
  arrayDereference =
    {
      array,
      index,
    }:
    {
      inherit array index;
    };
  boolean = value: {
    inherit value;
    nodeType = nodeTypes.members.boolean;
  };
  functionDefinition =
    { arguments, body }:
    {
      inherit arguments body;
      nodeType = nodeTypes.members.functionDefinition;
    };
  functionInvocation =
    { function, parameters }:
    {
      inherit function parameters;
      nodeType = nodeTypes.members.functionInvocation;
    };
  identifier = name: {
    inherit name;
    nodeType = nodeTypes.members.identifier;
  };
  number = value: {
    inherit value;
    nodeType = nodeTypes.members.number;
  };
  record =
    {
      entries,
      formatKeys ? false,
    }:
    {
      inherit entries formatKeys;
      nodeType = nodeTypes.members.record;
    };
  recordDereference =
    {
      key,
      record,
    }:
    {
      inherit key record;
      nodeType = nodeTypes.members.recordDereference;
    };
  string = value: {
    inherit value;
    nodeType = nodeTypes.members.string;
  };
}
