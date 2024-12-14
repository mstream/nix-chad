{ lib, ... }:
{
  create =
    {
      mappings ? { },
      memberNames,
      name,
    }:
    let
      enum = lib.yants.enum name memberNames;
      mapWith = mapping: member: enum.match member mapping;
      mapTo = lib.core.mapAttrs (
        _: mapping: (member: mapWith mapping member)
      ) mappings;
      members = lib.core.foldl' (
        acc: memberName:
        acc
        // {
          ${memberName} = enum memberName;
        }
      ) { } memberNames;
    in
    {
      inherit mapTo mapWith members;
    };
}
