let
  function = string: "${string}${string}";
  string = "foo";
  nestedFunction =
    n:
    let
      array1 = [
        0
        1
        2
        3
        4
        5
        6
        7
        8
        9
      ];
      array2 = [
        0
        1
        2
        3
        4
        5
        6
        7
        8
        9
      ];
      array3 = [
        0
        1
        2
        3
        4
        5
        6
        7
        8
        9
      ];
      level1 =
        n1:
        let
          level2 =
            n2:
            let
              level3 =
                n3:
                let
                  level4 = n4: n4;
                in
                level4 n3;
            in
            level3 n2;
        in
        level2 n1;
    in
    builtins.foldl' (acc: x: acc + x) (level1 n) (
      array1 ++ array2 ++ array3
    );
in
{
  inherit function nestedFunction string;
}
