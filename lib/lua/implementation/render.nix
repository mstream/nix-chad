{
  chadLib,
  nodeTypes,
  validators,
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
    (
      with chadLib.yants;
      defun [
        (either validators.anyNode validators.rawNode)
        string
      ]
    )
      (
        node:
        let
          renderNode = nodeTypes.mapWith renderers node.nodeType;
        in
        renderNode node
      );

  renderers = chadLib.fixedPoints.fix (self: {
    array =
      { elements, ... }:
      let
        bodyRep = chadLib.strings.concatMapStringsSep "," render elements;
      in
      "{${bodyRep}}";

    arrayDereference =
      { array, index, ... }:
      let
        arrayRep = render array;
        indexRep = render index;
      in
      "${arrayRep}[ ${indexRep} ]";

    boolean = { value, ... }: if value then "true" else "false";

    functionDefinition =
      { arguments, body, ... }:
      let
        argumentsRep = chadLib.strings.concatStringsSep "," arguments;

        bodyRep =
          if chadLib.core.isList body then
            chadLib.strings.concatMapStringsSep " " render body
          else
            self.raw body;

      in
      "function(${argumentsRep}) ${bodyRep} end";

    functionInvocation =
      { function, parameters, ... }:
      let
        functionRep = render function;
        parametersRep =
          chadLib.strings.concatMapStringsSep "," render
            parameters;
      in
      "${functionRep}(${parametersRep})";

    identifier = { name, ... }: name;

    number = { value, ... }: chadLib.core.toString value;

    raw = { blob, ... }: blob;

    record =
      { entries, formatKeys, ... }:
      let
        renderKey = chadLib.functions.compose [
          (if formatKeys then camelToSnakeCase else chadLib.functions.identity)
          (value: self.string { inherit value; })
        ];

        payloadRep = chadLib.strings.concatMapStringsSep "," (
          { name, value }:
          let
            keyRep = renderKey name;
            nodeRep = render value;
          in
          "[ ${keyRep} ]=${nodeRep}"
        ) (chadLib.attrsets.attrsToList entries);
      in
      "{${payloadRep}}";

    recordDereference =
      { key, record, ... }:
      let
        keyRep = render key;
        recordRep = render record;
      in
      "${recordRep}[ ${keyRep} ]";

    string = { value, ... }: "[[${value}]]";
  });
in
render
