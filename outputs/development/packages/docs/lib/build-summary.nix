{
  chadLib,
  chadLibBundle,
  chadLibCategoryBaseFileName,
  pkgs,
  ...
}:
let
  chadLibraryListAst =
    with chadLib.markdown.ast;
    list {
      items = [
        (listItem [
          (paragraph [
            (link {
              text = "Chad Library";
              url = "for-developers/chad-library/README.md";
            })
          ])
          (list {
            items = chadLib.attrsets.mapAttrsToList (
              moduleBundleName: moduleBundleDescription:
              listItem [
                (paragraph [
                  (link {
                    text = "${moduleBundleDescription} (${moduleBundleName})";
                    url = "for-developers/chad-library/${chadLibCategoryBaseFileName moduleBundleName}.md";
                  })
                ])
              ]
            ) chadLibBundle.descriptions;
            ordered = false;
          })
        ])
      ];
      ordered = false;
    };

  ast = with chadLib.markdown.ast; [
    (heading {
      depth = 1;
      text = "Summary";
    })
    (paragraph [
      (link {
        text = "Introduction";
        url = "README.md";
      })
    ])
    (heading {
      depth = 1;
      text = "User Guide";
    })
    (heading {
      depth = 1;
      text = "Reference Guide";
    })
    (list {
      items = [
        (listItem [
          (paragraph [
            (link {
              text = "Options";
              url = "options.generated.md";
            })
          ])
        ])
        (listItem [
          (paragraph [
            (link {
              text = "Key Mappings";
              url = "keymaps.generated.md";
            })
          ])
        ])
        (listItem [
          (paragraph [
            (link {
              text = "For Developers";
              url = "for-developers/README.md";
            })
          ])
          chadLibraryListAst
        ])
      ];
      ordered = false;
    })
  ];
  summaryFile = pkgs.writeTextFile {
    name = "SUMMARY.md";
    text = chadLib.markdown.render ast;
  };
in
pkgs.stdenv.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp ${summaryFile} $out/SUMMARY.md
  '';
  name = "nix-chad-summary";
  src = ../../../../../lib;
}
