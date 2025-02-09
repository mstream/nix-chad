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
  testRenderBreak = testCase {
    expectedCode = ''
      foo  
      bar
    '';
    node =
      with implementation.ast;
      paragraph [
        (text "foo")
        lineBreak
        (text "bar")
      ];
  };
  testRenderHeading = testCase {
    expectedCode = ''
      ### foo bar
    '';
    node =
      with implementation.ast;
      heading {
        depth = 3;
        text = "foo bar";
      };
  };
  testRenderLink = testCase {
    expectedCode = ''
      [foo](https://example.com)
    '';
    node =
      with implementation.ast;
      link {
        text = "foo";
        url = "https://example.com";
      };
  };
  testRenderNestedList = testCase {
    expectedCode = ''
      - foo
      - bar
        - baz
        - qux
    '';
    node =
      with implementation.ast;
      list {
        items = [
          (listItem [
            (paragraph [
              (text "foo")
            ])
          ])
          (listItem [
            (paragraph [
              (text "bar")
            ])
            (list {
              items = [
                (listItem [
                  (paragraph [
                    (text "baz")
                  ])
                ])
                (listItem [
                  (paragraph [
                    (text "qux")
                  ])
                ])
              ];
            })
          ])
        ];
      };
  };
  testRenderParagraph = testCase {
    expectedCode = ''
      foo bar
    '';
    node =
      with implementation.ast;
      paragraph [
        (text "foo bar")
      ];
  };
  testRenderText = testCase {
    expectedCode = ''
      foo
    '';
    node = with implementation.ast; text "foo";
  };
  testRenderOrderedList = testCase {
    expectedCode = ''
      1. foo
      1. bar
    '';
    node =
      with implementation.ast;
      list {
        items = [
          (listItem [
            (paragraph [
              (text "foo")
            ])
          ])
          (listItem [
            (paragraph [
              (text "bar")
            ])
          ])
        ];
        ordered = true;
      };
  };
  testRenderUnorderedList = testCase {
    expectedCode = ''
      - foo
      - bar
    '';
    node =
      with implementation.ast;
      list {
        items = [
          (listItem [
            (paragraph [
              (text "foo")
            ])
          ])
          (listItem [
            (paragraph [
              (text "bar")
            ])
          ])
        ];
      };
  };
}
