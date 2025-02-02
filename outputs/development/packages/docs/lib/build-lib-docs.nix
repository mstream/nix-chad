{
  chadLib,
  chadLibBundle,
  pkgs,
  ...
}:
let
  bulletPoint = categoryName: ''
    - [${categoryName}](./${chadLib.strings.camelToKebabCase categoryName}.md)
  '';

  genCategoryBashCommands = chadLib.attrsets.mapAttrsToList (
    categoryName: categoryDescription:
    let
      descriptionRep = chadLib.strings.escapeShellArg categoryDescription;
      srcLocationRep = "$src/${chadLib.strings.camelToKebabCase categoryName}/implementation/default.nix";
      docLocationRep = "$out/${chadLib.strings.camelToKebabCase categoryName}.md";
      bulletPointRep = chadLib.strings.escapeShellArg (
        bulletPoint categoryName
      );
    in
    ''
      doc_gen ${categoryName} ${descriptionRep} ${srcLocationRep} ${docLocationRep} ${bulletPointRep}
    ''
  ) chadLibBundle.descriptions;

  genCategoriesBash = chadLib.strings.concatStrings genCategoryBashCommands;

in
pkgs.stdenv.mkDerivation {
  installPhase = ''
    function doc_gen {
      local name=$1
      local description=$2
      local src_location=$3
      local doc_location=$4
      local bullet_point=$5
      
      nixdoc \
        --description "$description" \
        --category "$name" \
        --prefix "lib" \
        --file "$src_location"
        > "$doc_location"

      echo "$bullet_point" >> $out/README.md
    }

    mkdir $out
    echo "# Chad Library" > $out/README.md
    echo "" >> $out/README.md
    export RUST_BACKTRACE=full
    ${genCategoriesBash}
  '';
  name = "nix-chad-lib-docs";
  nativeBuildInputs = with pkgs; [ nixdoc ];
  src = ../../../../../lib;
}
