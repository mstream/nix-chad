{
  chadLib,
  nodeTypes,
  ...
}:
with chadLib.yants;
rec {
  anyNode = eitherN [
    literalNode
    expressionNode
    functionDefinitionNode
  ];

  arrayNode = struct "arrayNode" {
    nodeType = nodeTypeOf nodeTypes.members.array;
    elements = list anyNode;
  };

  arrayDereferenceNode = struct "arrayDereferenceNode" {
    array = expressionNode;
    index = arrayIndexNode;
    nodeType = nodeTypeOf nodeTypes.members.arrayDereference;
  };

  arrayIndexNode = either numberNode expressionNode;

  booleanNode = struct "booleanNode" {
    nodeType = nodeTypeOf nodeTypes.members.boolean;
    value = bool;
  };

  expressionNode = eitherN [
    arrayDereferenceNode
    functionInvocationNode
    identifierNode
    recordDereferenceNode
  ];

  functionArguments = list string;

  functionBody = either (list (eitherN [
    functionDefinitionNode
    functionInvocationNode
  ])) rawNode;

  functionDefinitionNode = struct "functionDefinitionNode" {
    arguments = functionArguments;
    body = functionBody;
    nodeType = nodeTypeOf nodeTypes.members.functionDefinition;
  };

  functionInvocationNode = struct "functionInvocationNode" {
    function = expressionNode;
    nodeType = nodeTypeOf nodeTypes.members.functionInvocation;
    parameters = list anyNode;
  };

  identifierNode = struct "identifierNode" {
    name = string;
    nodeType = nodeTypeOf nodeTypes.members.identifier;
  };

  literalNode = eitherN [
    arrayNode
    booleanNode
    numberNode
    recordNode
    stringNode
  ];

  nodeCreatingFunctions =
    chadLib.core.mapAttrs (chadLib.functions.constant defun)
      {
        _raw = [
          string
          rawNode
        ];
        array = [
          (list anyNode)
          arrayNode
        ];
        arrayDereference = [
          (struct "arrayDereferenceNodeArgs" {
            index = int;
            record = expressionNode;
          })
          recordDereferenceNode
        ];
        boolean = [
          bool
          booleanNode
        ];
        functionDefinition = [
          (struct "functionDefinitionArgs" {
            arguments = functionArguments;
            body = functionBody;
          })
          functionDefinitionNode
        ];
        functionInvocation = [
          (struct "functionInvocationArgs" {
            function = expressionNode;
            parameters = list anyNode;
          })
          functionInvocationNode
        ];
        identifier = [
          string
          identifierNode
        ];
        number = [
          number
          numberNode
        ];
        recordDereference = [
          (struct "recordDereferenceNodeArgs" {
            key = recordKeyNode;
            record = expressionNode;
          })
          recordDereferenceNode
        ];
        record = [
          (struct "recordNodeArgs" {
            entries = attrs anyNode;
            formatKeys = option bool;
          })
          recordNode
        ];
        string = [
          string
          stringNode
        ];
      };

  nodeTypeOf =
    nodeTypeMember:
    restrict "nodeType:${nodeTypeMember}" (s: s == nodeTypeMember) string;

  number = either int float;

  numberNode = struct "numberNode" {
    nodeType = nodeTypeOf nodeTypes.members.number;
    value = number;
  };

  rawNode = struct "rawNode" {
    blob = string;
    nodeType = nodeTypeOf nodeTypes.members.raw;
  };

  recordDereferenceNode = struct "recordDereferenceNode" {
    key = recordKeyNode;
    nodeType = nodeTypeOf nodeTypes.members.recordDereference;
    record = expressionNode;
  };

  recordKeyNode = either expressionNode literalNode;

  recordNode = struct "recordNode" {
    entries = attrs anyNode;
    formatKeys = bool;
    nodeType = nodeTypeOf nodeTypes.members.record;
  };

  stringNode = struct "stringNode" {
    nodeType = nodeTypeOf nodeTypes.members.string;
    value = string;
  };
}
