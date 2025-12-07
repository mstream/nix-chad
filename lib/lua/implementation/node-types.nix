{
  chadLib,
  ...
}:
chadLib.enum.create {
  memberNames = [
    "array"
    "arrayDereference"
    "boolean"
    "functionDefinition"
    "functionInvocation"
    "identifier"
    "number"
    "raw"
    "record"
    "recordDereference"
    "string"
  ];
  name = "nodeTypes";
}
