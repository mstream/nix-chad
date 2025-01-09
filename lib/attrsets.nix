{
  core,
  nixpkgsLibAttrsets,
  yants,
  ...
}:
let
  validators = with yants; {
    generate = defun [
      (list any)
      (defun [
        any
        (attrs any)
      ])
      (attrs any)
    ];
  };

  merge =
    let
      merge' =
        keyPath: leftAttrs: rightAttrs:
        let
          duplicatedKeys = core.attrNames (
            core.intersectAttrs leftAttrs rightAttrs
          );
          unmergableDuplicatedKeys = core.filter (
            key: !core.isAttrs leftAttrs.${key} || !core.isAttrs rightAttrs.${key}
          ) duplicatedKeys;
        in
        if core.length unmergableDuplicatedKeys > 0 then
          let
            keysRep = core.toString (
              core.map (key: "${keyPath}.${key}") unmergableDuplicatedKeys
            );
          in
          throw ''
            Can't merge attribute sets because of unmergable duplicated keys:
            ${keysRep}
          ''
        else
          leftAttrs
          // (core.removeAttrs rightAttrs duplicatedKeys)
          // (nixpkgsLibAttrsets.genAttrs duplicatedKeys (
            key: merge' "${keyPath}.${key}" leftAttrs.${key} rightAttrs.${key}
          ));
    in
    merge' "";

  generate = validators.generate (
    values: valueToAttrs:
    core.foldl' (acc: value: merge acc (valueToAttrs value)) { } values
  );
in
{

  implementation = { inherit generate merge; };
  tests = { };
}
