{
  chadLib,
  nodeTypes,
  ...
}:
let
  camelToSnakeCase = chadLib.strings.stringAsChars (
    char:
    if chadLib.strings.toUpper char == char then
      "_${chadLib.strings.toLower char}"
    else
      char
  );

  render =
    node:
    let
      renderNode = nodeTypes.mapWith renderers node.nodeType;
    in
    renderNode node;

  renderers = chadLib.fixedPoints.fix (self: {
    array =
      { elements, ... }:
      let
        bodyRep = chadLib.strings.concatMapStringsSep "," render elements;
      in
      "{${bodyRep}}";

    boolean = { value, ... }: if value then "true" else "false";

    functionDefinition =
      { arguments, bodyStatements, ... }:
      let
        argumentsRep = chadLib.strings.concatStringsSep "," arguments;
        bodyStatementsRep =
          chadLib.strings.concatMapStringsSep " " render
            bodyStatements;
      in
      "function(${argumentsRep}) ${bodyStatementsRep} end";

    functionInvocation =
      { functionExpression, parameterExpressions, ... }:
      let
        functionExpressionRep = render functionExpression;
        parameterExpressionsRep =
          chadLib.strings.concatMapStringsSep "," render
            parameterExpressions;
      in
      "${functionExpressionRep}(${parameterExpressionsRep})";

    identifier = { name, ... }: name;

    number = { value, ... }: chadLib.core.toString value;

    raw = { blob, ... }: blob;

    record =
      { attrs, formatKeys, ... }:
      let
        renderKey = chadLib.functions.compose [
          (if formatKeys then camelToSnakeCase else chadLib.functions.identity)
          (value: self.string { inherit value; })
        ];

        bodyRep = chadLib.strings.concatMapStringsSep "," (
          { name, value }:
          let
            keyRep = renderKey name;
            nodeRep = render value;
          in
          "[ ${keyRep} ]=${nodeRep}"
        ) (chadLib.attrsets.attrsToList attrs);
      in
      "{${bodyRep}}";

    recordDereference =
      { keyExpression, recordExpression, ... }:
      let
        keyExpressionRep = render keyExpression;
        recordExpressionRep = render recordExpression;
      in
      "${recordExpressionRep}[ ${keyExpressionRep} ]";

    string = { value, ... }: "[[${value}]]";
  });
in
render
