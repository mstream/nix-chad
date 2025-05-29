{
  chadLib,
  chadLibBundle,
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
  chadEvaluatedModules = chadLib.modules.evalModules {
    class = "chad";
    modules = [
      {
        _module.check = false;
      }
      chadModulePath
    ];
    specialArgs = { inherit chadLib; };
  };
  keymapsDocs = buildKeymapsDocs {
    inherit chadEvaluatedModules;
  };
  optionsDocs = buildOptionsDocs {
    inherit chadEvaluatedModules;
    nixpkgsRef =
      (chadLib.core.fromJSON (chadLib.core.readFile ../../../../flake.lock))
      .nodes.nixpkgs.original.ref;
  };

  chadLibCategoryBaseFileName = chadLib.strings.camelToKebabCase;

  summary = import ./lib/build-summary.nix {
    inherit
      chadLib
      chadLibBundle
      chadLibCategoryBaseFileName
      pkgs
      ;
  };

  chadLibDocs = import ./lib/build-lib-docs.nix {
    inherit chadLib chadLibBundle pkgs;
    categoryBaseFileName = chadLibCategoryBaseFileName;
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
    nodePackages.markdownlint-cli2
    vale
  ];
  checkPhase = ''
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
    mkdir -p src/for-developers/chad-library
    cp ${chadLibDocs}/*.md src/for-developers/chad-library
    cp $src/markdownlint.json .markdownlint.json
    cp -r $src/markdown/* src/
    cp ${summary}/SUMMARY.md src/
    cp -r $src/assets src/
    cat ${keymapsDocs.keymapsCommonMark} > src/keymaps.generated.md
    cat ${optionsDocs.optionsCommonMark} > src/options.generated.md
  '';
  name = "nix-chad-docs";
  src = ./src;
}
