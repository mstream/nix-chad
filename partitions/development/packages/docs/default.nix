{
  chadLib,
  pkgs,
  vale,
  ...
}:
let
  repoRootPath = ../../../..;
  chadModulePath = repoRootPath + /modules/darwin/chad;
  inherit (import ./lib { inherit chadLib pkgs; })
    buildKeymapsDocs
    buildOptionsDocs
    ;
  evaluatedModules = chadLib.modules.evalModules {
    class = "chad";
    modules = [
      {
        _module.check = false;
      }
      chadModulePath
    ];
    specialArgs = { inherit chadLib; };
  };
  keymapsDocs = buildKeymapsDocs { inherit evaluatedModules; };
  optionsDocs = buildOptionsDocs {
    inherit evaluatedModules;
    nixpkgsRef =
      (chadLib.core.fromJSON (chadLib.core.readFile ../../flake.lock))
      .nodes.nixpkgs.original.ref;
  };

  validationBashFunction =
    validationKind: validationProgram: with chadLib.bash; ''
      function validate_${validationKind}() {
        file=$1
        echo "checking ${validationKind} of $file"
        ${catchErrorExec [ "${validationProgram} $file" ]}
        if [ ${refs.returnCode} -ne 0 ]; then
          ${echoError "Offending file's ($file) contents:"} 
          nl -w2 -s "> " $file >&2
          ${echoError "Found ${validationKind} problems:"} 
          ${echoError refs.output}
          return 1
        else
          return 0
        fi
      }
    '';
in
pkgs.stdenv.mkDerivation {
  nativeBuildInputs = with pkgs; [
    nixdoc
    nodePackages.markdownlint-cli2
    vale
  ];
  checkPhase = with chadLib.bash; ''
    ${validationBashFunction "spelling" "vale"}
    ${validationBashFunction "syntax" "markdownlint-cli2"}

    for f in ./src/*.md; do
      validate_syntax "$f" || exit 1;
      validate_spelling "$f" || exit 1;
    done
  '';
  doCheck = true;
  installPhase = ''
    cp -r src "$out"
  '';
  unpackPhase = ''
    export RUST_BACKTRACE=full
    docs_src="$src/partitions/development/packages/docs/docs-src"
    mkdir -p src/for-developers
    cp $docs_src/markdownlint.json .markdownlint.json
    cp $docs_src/markdown/* src/
    cat ${keymapsDocs.keymapsCommonMark} > src/keymaps.generated.md
    cat ${optionsDocs.optionsCommonMark} > src/options.generated.md

    nixdoc \
      --prefix 'lib' \
      --category 'darwin' \
      --description 'Nix Chad Library' \
      --file $src/partitions/public/darwin.nix \
      > src/for-developers/library.generated.md
  '';
  name = "docs";
  src = repoRootPath;
}
