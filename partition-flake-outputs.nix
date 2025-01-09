{ chadLib, partitions, ... }:
let
  allPartitionMembers = chadLib.core.attrValues partitions.members;
  generate = chadLib.attrsets.generate allPartitionMembers;
in
{
  partitionedAttrs = generate (
    partition:
    let
      partitionName = partitions.mapTo.name partition;
      partitionOutputAttrNames = partitions.mapTo.flakeOutputAttributeNames partition;
    in
    chadLib.attrsets.genAttrs partitionOutputAttrNames (
      chadLib.functions.constant partitionName
    )
  );

  partitions = generate (
    partition:
    let
      partitionName = partitions.mapTo.name partition;
      partitionExtraInputsFlakePath = partitions.mapTo.extraInputsFlakePath partition;
      partitionModulePath = partitions.mapTo.modulePath partition;
    in
    {
      ${partitionName} = {
        extraInputsFlake = partitionExtraInputsFlakePath;
        module = {
          imports = [ partitionModulePath ];
        };
      };
    }
  );
}
