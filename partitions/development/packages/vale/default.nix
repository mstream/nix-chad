{ chadLib, pkgs, ... }:
let
  styles = pkgs.callPackage ./styles { inherit chadLib; };

  enabledStyleNames = [ "write-good" ];

  basedOnStyles = chadLib.strings.concatStringsSep "," enabledStyleNames;

  valeConfigFileText = ''
    StylesPath = styles
    [*]
    BasedOnStyles = ${basedOnStyles}
  '';

  valeConfigFilePath = "share/vale/.vale.ini";
  valeConfig = pkgs.writeTextDir valeConfigFilePath valeConfigFileText;
in
pkgs.symlinkJoin {
  name = "nix-chad-vale";
  nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  paths =
    [
      pkgs.vale
      valeConfig
    ]
    ++ (chadLib.core.map (
      styleName: styles.${styleName}
    ) enabledStyleNames);
  postBuild = ''
    wrapProgram "$out/bin/vale" \
      --add-flags "--config=$out/${valeConfigFilePath}" \
      --add-flags "--no-global"
  '';
}
