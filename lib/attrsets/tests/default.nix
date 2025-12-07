implementation: {
  testGenerate = {
    expected = {
      a1 = "a";
      a2 = "a";
      b1 = "b";
      b2 = "b";
      c1 = "c";
      c2 = "c";
    };
    expr = implementation.generate [ "a" "b" "c" ] (v: {
      "${v}1" = v;
      "${v}2" = v;
    });
  };
  testMerge = {
    expected = {
      a = "a";
      b = "b";
      c = {
        c1 = "c1";
        c2 = "c2";
      };
    };
    expr =
      implementation.merge
        {
          a = "a";
          c = {
            c1 = "c1";
          };
        }
        {
          b = "b";
          c = {
            c2 = "c2";
          };
        };
  };
}
