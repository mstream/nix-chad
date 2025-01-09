{ pkgs, ... }:
pkgs.writeScript "updateShortcuts.py" ''
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
''
