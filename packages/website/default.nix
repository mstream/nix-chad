{ pkgs, ... }:
let docs = import ../docs { inherit pkgs; };
in pkgs.stdenv.mkDerivation {
  nativeBuildInputs = with pkgs; [ mdbook mdbook-linkcheck mdbook-mermaid ];
  installPhase = ''
    mkdir "$out"
    mdbook build --dest-dir "$out" .;
  '';
  unpackPhase = ''
    cp -r ${docs} src
  '';
  name = "website";
  src = ./.;
}
