{
  chadLib,
  nodeTypes,
  ...
}:
let
  createValidator =
    nodeType: attrValidators:
    chadLib.yants.struct "${nodeType}Node" (
      attrValidators
      // {
        nodeType = chadLib.yants.restrict "${nodeType}EnumMember" (
          s: s == nodeType
        ) chadLib.yants.string;
      }
    );

  #TODO: Sometimes any node is too broad. Make more specific validators.
  anyNode = chadLib.yants.eitherN (
    chadLib.core.attrValues nodeValidators
  );

  nodeValidators = {
    array = createValidator nodeTypes.members.array {
      elements = chadLib.yants.list anyNode;
    };

    boolean = createValidator nodeTypes.members.boolean {
      value = chadLib.yants.bool;
    };

    functionDefinition =
      createValidator nodeTypes.members.functionDefinition
        {
          arguments = chadLib.yants.list chadLib.yants.string;
          bodyStatements = chadLib.yants.list anyNode;
        };

    functionInvocation =
      createValidator nodeTypes.members.functionInvocation
        {
          functionExpression = anyNode;
          parameterExpressions = chadLib.yants.list anyNode;
        };

    identifier = createValidator nodeTypes.members.identifier {
      name = chadLib.yants.string;
    };

    number = createValidator nodeTypes.members.number {
      value = chadLib.yants.either chadLib.yants.int chadLib.yants.float;
    };

    raw = createValidator nodeTypes.members.raw {
      blob = chadLib.yants.string;
    };

    record = createValidator nodeTypes.members.record {
      attrs = chadLib.yants.attrs anyNode;
      formatKeys = chadLib.yants.bool;
    };

    recordDereference =
      createValidator nodeTypes.members.recordDereference
        {
          keyExpression = anyNode;
          recordExpression = anyNode;
        };

    string = createValidator nodeTypes.members.string {
      value = chadLib.yants.string;
    };
  };
in
{
  array =
    elements:
    nodeValidators.array {
      inherit elements;
      nodeType = nodeTypes.members.array;
    };
  boolean =
    value:
    nodeValidators.boolean {
      inherit value;
      nodeType = nodeTypes.members.boolean;
    };
  functionDefinition =
    { arguments, bodyStatements }:
    nodeValidators.functionDefinition {
      inherit arguments bodyStatements;
      nodeType = nodeTypes.members.functionDefinition;
    };
  functionInvocation =
    { functionExpression, parameterExpressions }:
    nodeValidators.functionInvocation {
      inherit functionExpression parameterExpressions;
      nodeType = nodeTypes.members.functionInvocation;
    };
  identifier =
    name:
    nodeValidators.identifier {
      inherit name;
      nodeType = nodeTypes.members.identifier;
    };
  number =
    value:
    nodeValidators.number {
      inherit value;
      nodeType = nodeTypes.members.number;
    };
  raw =
    blob:
    nodeValidators.raw {
      inherit blob;
      nodeType = nodeTypes.members.raw;
    };
  record =
    {
      attrs,
      formatKeys ? false,
    }:
    nodeValidators.record {
      inherit attrs formatKeys;
      nodeType = nodeTypes.members.record;
    };
  recordDereference =
    {
      keyExpression,
      recordExpression,
    }:
    nodeValidators.recordDereference {
      inherit keyExpression recordExpression;
      nodeType = nodeTypes.members.recordDereference;
    };
  string =
    value:
    nodeValidators.string {
      inherit value;
      nodeType = nodeTypes.members.string;
    };
}
