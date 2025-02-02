{
  chadLib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;

  shortcutsSpec =
    chadLib.attrsets.generate
      (chadLib.core.attrValues chadLib.shortcuts.api.actions.members)
      (
        actionName:
        let
          actionId = chadLib.shortcuts.api.actions.mapTo.id actionName;
          combinationSpec =
            if chadLib.core.hasAttr actionName cfg.keyboard.shortcuts then
              let
                inherit (cfg.keyboard.shortcuts.${actionName}) modifierKeys otherKey;
              in
              chadLib.shortcuts.keyCombination modifierKeys otherKey
            else
              chadLib.shortcuts.disabled;
        in
        {
          ${chadLib.core.toString actionId} = combinationSpec;
        }
      );

  shortcutsSpecFile = pkgs.writeTextFile {
    name = "shortcutsSpec.json";
    text = chadLib.core.toJSON shortcutsSpec;
  };

  updateShortcutsScript = pkgs.writeScript "updateShortcuts.py" ''
    #!${pkgs.python3.interpreter}

    import json
    from os.path import expanduser
    import plistlib
    import sys

    path = expanduser('~/Library/Preferences/com.apple.symbolichotkeys.plist')

    with open(path, 'rb') as f:
      plist = plistlib.load(f)

    with open(sys.argv[1], 'rb') as f:
      updates = json.load(f)

    plist['AppleSymbolicHotKeys'].update(updates)

    with open(path, 'wb') as f:
      plistlib.dump(plist, f)
  '';

  copySystemCertificatesToNixBashScriptSource = ''
    if [ ! -f ${cfg.sslCertFilePath} ]; then
      tmp_dir=$(mktemp -d)

      security export \
        -t certs \
        -f pemseq \
        -k /Library/Keychains/System.keychain \
        -o "$tmp_dir/certs-system.pem"

      security export \
        -t certs \
        -f pemseq \
        -k /System/Library/Keychains/SystemRootCertificates.keychain \
        -o "$tmp_dir/certs-root.pem"

      cat "$tmp_dir/certs-root.pem" "$tmp_dir/certs-system.pem" \
        > "$tmp_dir/ca_cert.pem"

      sudo mv "$tmp_dir/ca_cert.pem" ${cfg.sslCertFilePath}
    fi
  '';

  updateAppleSymbolicHotKeysBashScriptSource = ''
    "${updateShortcutsScript}" "${shortcutsSpecFile}"

    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    killall -u ${cfg.user.name} cfprefsd
  '';
in
{
  system.activationScripts = {
    postActivation.text = ''
      ${copySystemCertificatesToNixBashScriptSource}
    '';
    postUserActivation.text = ''
      ${updateAppleSymbolicHotKeysBashScriptSource}
    '';
  };
}
