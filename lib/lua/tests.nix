implementation:
let
  testCase =
    { node, expectedCode }:
    {
      expr = implementation.render node;
      expected = expectedCode;
    };
in
{
  testRenderArray = testCase {
    expectedCode = "{123,[[abc]]}";
    node =
      with implementation.ast;
      array [
        (number 123)
        (string "abc")
      ];
  };

  testRenderFlatRecord = testCase {
    expectedCode = "{[ [[k1]] ]=[[v1]],[ [[k2]] ]=[[v2]]}";
    node =
      with implementation.ast;
      record {
        entries = {
          k1 = string "v1";
          k2 = string "v2";
        };
      };
  };

  testRenderFunctionDefinition = testCase {
    expectedCode = "function(arg1,arg2) print([[hello world!]]) print(arg1) print(arg2) end";
    node =
      with implementation.ast;
      functionDefinition {
        arguments = [
          "arg1"
          "arg2"
        ];
        body = [
          (functionInvocation {
            function = identifier "print";
            parameters = [ (string "hello world!") ];
          })
          (functionInvocation {
            function = identifier "print";
            parameters = [ (identifier "arg1") ];
          })
          (functionInvocation {
            function = identifier "print";
            parameters = [ (identifier "arg2") ];
          })
        ];
      };
  };

  testRednerFunctionInvocation = testCase {
    expectedCode = "abc(1,{[ [[k1]] ]=[[v1]]})";
    node =
      with implementation.ast;
      functionInvocation {
        function = identifier "abc";
        parameters = [
          (number 1)
          (record {
            entries = {
              k1 = string "v1";
            };
          })
        ];
      };
  };

  testRenderIdentifier = testCase {
    expectedCode = "abc";
    node = with implementation.ast; identifier "abc";
  };

  testRenderNestedRecord = testCase {
    expectedCode = "{[ [[k1]] ]=[[v1]],[ [[k2]] ]={[ [[k21]] ]=[[v21]]},[ [[k3]] ]=[[v3]]}";
    node =
      with implementation.ast;
      record {
        entries = {
          k1 = string "v1";
          k2 = record {
            entries = {
              k21 = string "v21";
            };
          };
          k3 = string "v3";
        };
      };
  };

  testRenderNumber = testCase {
    expectedCode = "123";
    node = with implementation.ast; number 123;
  };

  testRenderRecordDereference = testCase {
    expectedCode = "kvs[ [[k1]] ]";
    node =
      with implementation.ast;
      recordDereference {
        key = string "k1";
        record = identifier "kvs";
      };
  };

  testRenderReformattedKeysRecord = testCase {
    expectedCode = "{[ [[foo_bar_biz]] ]=[[value of fooBarBiz]]}";
    node =
      with implementation.ast;
      record {
        entries = {
          fooBarBiz = string "value of fooBarBiz";
        };
        formatKeys = true;
      };
  };

  testRenderString = testCase {
    node = with implementation.ast; string "abc";
    expectedCode = "[[abc]]";
  };
}
