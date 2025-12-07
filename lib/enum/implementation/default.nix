chadLib:
let
  validators = with chadLib.yants; rec {
    create = defun [
      (struct "args" {
        inherit memberNames name;
        mappings = option mappings;
      })
      (struct "returnValue" {
        inherit
          enum
          mapTo
          mapWith
          members
          ;
      })
    ];

    enum = any;

    mapTo = attrs function;

    mapWith = function;
    mapping = attrs any;
    mappings = attrs mapping;
    memberName = string;
    memberNames = list memberName;
    members = attrs memberName;
    name = string;
  };

  create = validators.create (
    {
      mappings ? { },
      memberNames,
      name,
    }:
    let
      enum = chadLib.yants.enum name memberNames;

      mapWith =
        (chadLib.yants.defun [
          validators.mapping
          validators.memberName
          chadLib.yants.any
        ])
          (mapping: memberName: enum.match memberName mapping);

      mapTo = chadLib.core.mapAttrs (chadLib.functions.constant (
        mapping:
        (chadLib.yants.defun [
          validators.memberName
          chadLib.yants.any
        ])
          (mapWith mapping)
      )) mappings;

      members = chadLib.attrsets.genAttrs memberNames enum;
    in
    {
      inherit
        enum
        mapTo
        mapWith
        members
        ;
    }
  );
in
{
  inherit create;
}
