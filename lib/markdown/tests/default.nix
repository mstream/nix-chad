implementation:
let
  testCase =
    { document, expectedCode }:
    {
      expr = implementation.render document;
      expected = expectedCode;
    };
in
{
  testRenderHeading = testCase {
    document = with implementation.ast; [
      (heading {
        depth = 3;
        text = "foo bar";
      })
    ];
    expectedCode = ''
      ### foo bar
    '';
  };
  testRenderLineBreak = testCase {
    document = with implementation.ast; [
      (paragraph [
        (text "foo")
        lineBreak
        (text "bar")
      ])
    ];
    expectedCode = ''
      foo  
      bar
    '';

  };
  testRenderLink = testCase {
    document = with implementation.ast; [
      (paragraph [
        (link {
          text = "foo";
          url = "https://example.com";
        })
      ])
    ];
    expectedCode = ''
      [foo](https://example.com)
    '';
  };
  testRenderNestedList = testCase {
    document = with implementation.ast; [
      (list {
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
      })
    ];
    expectedCode = ''
      - foo
      - bar
        - baz
        - qux
    '';

  };
  testRenderParagraph = testCase {
    document = with implementation.ast; [
      (paragraph [
        (text "foo bar")
      ])
    ];
    expectedCode = ''
      foo bar
    '';
  };
  testRenderText = testCase {
    document = with implementation.ast; [
      (paragraph [ (text "foo") ])
    ];
    expectedCode = ''
      foo
    '';
  };
  testRenderThematicBreak = testCase {
    document = with implementation.ast; [ thematicBreak ];
    expectedCode = ''
      ---
    '';
  };
  testRenderOrderedList = testCase {
    document = with implementation.ast; [
      (list {
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
      })
    ];
    expectedCode = ''
      1. foo
      1. bar
    '';
  };
  testRenderUnorderedList = testCase {
    document = with implementation.ast; [
      (list {
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
      })
    ];
    expectedCode = ''
      - foo
      - bar
    '';
  };
}
