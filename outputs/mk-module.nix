{
  debug,
  chadLib,
  ciSystems,
  flake-parts,
  partitions,
  ...
}:
let
  allPartitionMembers = chadLib.core.attrValues partitions.members;
  generateWithPartitions = chadLib.attrsets.generate allPartitionMembers;

  testsFlakeModule =
    { chadLibBundle, ... }:
    {
      flake.tests.chadLib = chadLibBundle.tests;
    };
in
chadLib.functions.constant {
  inherit debug;

  imports = [
    flake-parts.flakeModules.partitions
    testsFlakeModule
  ];

  partitionedAttrs = generateWithPartitions (
    partition:
    let
      partitionName = partitions.mapTo.name partition;
      partitionOutputAttrNames = partitions.mapTo.flakeOutputAttributeNames partition;
    in
    chadLib.attrsets.genAttrs partitionOutputAttrNames (
      chadLib.functions.constant partitionName
    )
  );

  partitions = generateWithPartitions (
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

  systems = ciSystems;
}
