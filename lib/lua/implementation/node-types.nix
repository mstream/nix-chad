{
  chadLib,
  ...
}:
chadLib.enum.create {
  memberNames = [
    "array"
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
