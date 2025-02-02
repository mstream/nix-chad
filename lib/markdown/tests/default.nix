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
    expectedCode = "foo  \nbar";
    node =
      with implementation.ast;
      paragraph [
        (text "foo")
        break
        (text "bar")
      ];
  };
  testRenderHeading = testCase {
    expectedCode = "### foo bar";
    node =
      with implementation.ast;
      heading {
        depth = 3;
        text = "foo bar";
      };
  };
  testRenderLink = testCase {
    expectedCode = "[foo](https://example.com)";
    node =
      with implementation.ast;
      link {
        text = "foo";
        url = "https://example.com";
      };
  };
  testRenderNestedList = testCase {
    expectedCode = "- foo\n- bar";
    node =
      with implementation.ast;
      list {
        items = [
          (listItem paragraph [
            (text "foo")
          ])
          (listItem (paragraph [
            (text "bar")
          ]))
        ];
      };
  };
  testRenderParagraph = testCase {
    expectedCode = "foo bar";
    node =
      with implementation.ast;
      paragraph [
        (text "foo bar")
      ];
  };
  testRenderText = testCase {
    expectedCode = "foo";
    node = with implementation.ast; text "foo";
  };
  testRenderOrderedList = testCase {
    expectedCode = "1. foo\n1. bar";
    node =
      with implementation.ast;
      list {
        items = [
          (listItem (paragraph [
            (text "foo")
          ]))
          (listItem (paragraph [
            (text "bar")
          ]))
        ];
        ordered = true;
      };
  };
  testRenderUnorderedList = testCase {
    expectedCode = "- foo\n- bar";
    node =
      with implementation.ast;
      list {
        items = [
          (listItem (paragraph [
            (text "foo")
          ]))
          (listItem (paragraph [
            (text "bar")
          ]))
        ];
      };
  };
}
