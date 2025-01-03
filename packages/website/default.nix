{ docs, pkgs, ... }:
pkgs.stdenv.mkDerivation {
  nativeBuildInputs = with pkgs; [
    mdbook
    mdbook-linkcheck
    mdbook-mermaid
    mdbook-toc
  ];
  installPhase = ''
    mkdir "$out"
    mdbook build --dest-dir "$out" .;
  '';
  unpackPhase = ''
    cp -r ${docs} src
    cp $src/book.toml .
    cp $src/*.js .
  '';
  name = "website";
  src = ./.;
}
