{ core, yants, ... }:
{
  create =
    {
      mappings ? { },
      memberNames,
      name,
    }:
    let
      enum = yants.enum name memberNames;
      mapWith = mapping: member: enum.match member mapping;
      mapTo = core.mapAttrs (
        _: mapping: (member: mapWith mapping member)
      ) mappings;
      members = core.foldl' (
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
