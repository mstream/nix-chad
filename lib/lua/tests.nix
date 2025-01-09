implementation:
let
  array = implementation.api.array [
    (implementation.api.number 123)
    (implementation.api.string "abc")
  ];

  flatRecord = implementation.api.record {
    attrs = {
      k1 = implementation.api.string "v1";
      k2 = implementation.api.string "v2";
    };
  };

  nestedRecord = implementation.api.record {
    attrs = {
      k1 = implementation.api.string "v1";
      k2 = implementation.api.record {
        attrs = {
          k21 = implementation.api.string "v21";
        };
      };
      k3 = implementation.api.string "v3";
    };
  };

  recordDereference = implementation.api.recordDereference {
    keyExpression = implementation.api.string "k1";
    recordExpression = implementation.api.identifier "kvs";
  };

  reformattedKeysRecord = implementation.api.record {
    attrs = {
      fooBarBiz = implementation.api.string "value of fooBarBiz";
    };
    formatKeys = true;
  };

  functionDefinition = implementation.api.functionDefinition {
    arguments = [
      "arg1"
      "arg2"
    ];
    bodyStatements = [
      (implementation.api.functionInvocation {
        functionExpression = implementation.api.identifier "print";
        parameterExpressions = [
          (implementation.api.string "hello world!")
        ];
      })
      (implementation.api.functionInvocation {
        functionExpression = implementation.api.identifier "print";
        parameterExpressions = [
          (implementation.api.identifier "arg1")
        ];
      })
      (implementation.api.functionInvocation {
        functionExpression = implementation.api.identifier "print";
        parameterExpressions = [
          (implementation.api.identifier "arg2")
        ];
      })
    ];
  };

  functionInvocation = implementation.api.functionInvocation {
    functionExpression = implementation.api.identifier "abc";
    parameterExpressions = [
      (implementation.api.number 1)
      (implementation.api.record {
        attrs = {
          k1 = implementation.api.string "v1";
        };
      })
    ];
  };

  identifier = implementation.api.identifier "abc";
  number = implementation.api.number 123;
  string = implementation.api.string "abc";
in
{
  testRenderArray = {
    expr = implementation.render array;
    expected = "{123,[[abc]]}";
  };
  testRenderFlatRecord = {
    expr = implementation.render flatRecord;
    expected = "{[ [[k1]] ]=[[v1]],[ [[k2]] ]=[[v2]]}";
  };
  testRenderFunctionDefinition = {
    expr = implementation.render functionDefinition;
    expected = "function(arg1,arg2) print([[hello world!]]) print(arg1) print(arg2) end";
  };
  testRednerFunctionInvocation = {
    expr = implementation.render functionInvocation;
    expected = "abc(1,{[ [[k1]] ]=[[v1]]})";
  };
  testRenderIdentifier = {
    expr = implementation.render identifier;
    expected = "abc";
  };
  testRenderNestedRecord = {
    expr = implementation.render nestedRecord;
    expected = "{[ [[k1]] ]=[[v1]],[ [[k2]] ]={[ [[k21]] ]=[[v21]]},[ [[k3]] ]=[[v3]]}";
  };
  testRenderNumber = {
    expr = implementation.render number;
    expected = "123";
  };
  testRenderRecordDereference = {
    expr = implementation.render recordDereference;
    expected = "kvs[ [[k1]] ]";
  };
  testRenderReformattedKeysRecord = {
    expr = implementation.render reformattedKeysRecord;
    expected = "{[ [[foo_bar_biz]] ]=[[value of fooBarBiz]]}";
  };
  testRenderString = {
    expr = implementation.render string;
    expected = "[[abc]]";
  };
}
