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

  /**
      Deep merge two attribute sets

      # Example

      ```nix
      merge {a="a";c={c1="c1";}} {b="b";c={c2="c2";}}
      =>
      {a="a";b="b";c={c1="c1";c2="c2";}}
      ```

      # Type

      ```
      merge :: AttrSet -> AttrSet -> AttrSet
      ```

      # Arguments

      left
      : Left attribute set

      right
      : Right attribute set
  */
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

  /**
     Generate an attribute set from a list of values

     # Example

     ```nix
     generate ["a" "b" "c"] (v: {"${v}1"=v;"${v}2"=v;})
     =>
     {a1="a";a2="a";b1="b";b2="b";c1="c";c2="c";}
     ```

     # Type

     ```
     generate :: [Any] -> (Any -> AttrSet) -> AttrSet
     ```

     # Arguments

     values
     : List of values

     generator
     : A function transforming a single value into an attribute set
  */
  generate = validators.generate (
    values: valueToAttrs:
    core.foldl' (acc: value: merge acc (valueToAttrs value)) { } values
  );
in
{
  inherit generate merge;
}
