{ pkgs, ... }:
with pkgs.lib;
let

  inherit (import ./lib { inherit pkgs; })
    buildKeymapsDocs
    buildOptionsDocs
    ;

  aspellEn = pkgs.aspellWithDicts (d: [
    d.en
    d.en-computers
  ]);

  evaluatedModules = evalModules {
    class = "chad";
    modules = [
      { _module.check = false; }
      ../../darwin-modules/chad/default.nix
    ];
  };

  keymapsDocs = buildKeymapsDocs { inherit evaluatedModules; };

  optionsDocs = buildOptionsDocs {
    inherit evaluatedModules;
    nixpkgsRef =
      (builtins.fromJSON (builtins.readFile ../../flake.lock))
      .nodes.nixpkgs.original.ref;
  };
in
pkgs.stdenv.mkDerivation {
  nativeBuildInputs =
    with pkgs;
    [ nodePackages.markdownlint-cli ] ++ [ aspellEn ];
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

    markdownlint --disable MD004 MD009 MD022 MD024 MD025 MD040 MD041 -- ./src

    for f in ./src/*.md; do
      validate_spelling "$f" || exit 1;
    done
  '';
  doCheck = true;
  installPhase = ''
    cp -r src "$out"
  '';
  unpackPhase = ''
    cp -r $src/docs src
    chmod --recursive u+w src
    cat ${keymapsDocs.keymapsCommonMark} > src/keymaps.generated.md
    cat ${optionsDocs.optionsCommonMark} > src/options.generated.md
    ${pkgs.nixdoc}/bin/nixdoc \
      --prefix 'lib' \
      --category 'darwin' \
      --description 'Nix Chad Library' \
      --file $src/lib/darwin.nix \
      > src/for-developers/library.generated.md
    cp $src/docs/.markdownlint.json .
    cp $src/docs/extra-dictionary.txt .
  '';
  name = "docs";
  src = ../..;
}
