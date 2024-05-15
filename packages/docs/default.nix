{ pkgs, ... }:
with pkgs.lib;
let
  aspellEn = pkgs.aspellWithDicts (d: [ d.en d.en-computers d.en-science ]);
  evaluatedModules = evalModules { 
    check = false; 
    modules = [ ../../modules/chad.nix ]; 
  };
  optionsDoc = pkgs.nixosOptionsDoc { options = evaluatedModules.options; };
in pkgs.stdenv.mkDerivation {
  nativeBuildInputs = with pkgs; [
    esbuild
    mdbook
    mdbook-linkcheck
    mdbook-mermaid
    nodePackages.markdownlint-cli
  ] ++ [aspellEn];
  checkPhase = ''
    function validate_spelling() {
      file=$1
      echo "checking spelling of $file"
      set +e
      cat $file | sed 's/#//g' | sed 's/[a-zA-Z0-9]\+\(_[a-zA-Z0-9]\+\)\+//g' | sed 's/```\S\+//g' | aspell pipe --dont-save-repl --lang en --mode=markdown --personal ./extra-dictionary.txt --camel-case | grep '^\&';
      grep_exit_code=$?
      set -e
      if [ "$grep_exit_code" -eq 1 ]; then
        return 0
      else
        return 1
      fi
    }

    for f in ./docs/test/valid/*.md; do
      validate_spelling $f || exit 1;
    done

    for f in ./docs/test/invalid/*.md; do
      (! validate_spelling "$f") || exit 1;
    done

    markdownlint --disable MD004 MD009 MD040 MD041 -- ./docs/src

    for f in ./docs/src/*.md; do
      validate_spelling "$f" || exit 1;
    done
  '';
  doCheck = true;
  installPhase = ''
    mkdir "$out"
    mdbook build --dest-dir "$out" docs
  '';
  unpackPhase = ''
    mkdir -p docs/src
    cat ${optionsDoc.optionsCommonMark} >> docs/src/options.md
    cp $src/SUMMARY.md docs/src/
    cp $src/.markdownlint.json .
    cp $src/extra-dictionary.txt .
  '';
  name = "docs";
  src = ./.;
}
