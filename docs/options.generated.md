## chad\.browser\.bookmarks

Browser bookmarks\.



*Type:*
(list of ((bookmark submodule) or (directory submodule))) or (attribute set of ((bookmark submodule) or (directory submodule))) convertible to it



*Default:*
` [ ] `



*Example:*

```
[
  {
    bookmarks = [
      {
        keyword = "nixpkgs";
        name = "NixOS Search - Packages";
        tags = [
          "nix"
        ];
        url = "https://search.nixos.org/packages";
      }
    ];
    name = "Nix sites";
    toolbar = true;
  }
  {
    title = "Nix Chad";
    url = "https://github.com/mstream/nix-chad";
  }
]
```

*Declared by:*
 - [\<nix-chad/modules/chad/browser\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/browser.nix)



## chad\.browser\.extraExtensions



Additional Firefox extensions to be installed for the user\.



*Type:*
null or (function that evaluates to a(n) list of package)



*Default:*
` null `



*Example:*

```
exts: with exts; [ honey ];

```

*Declared by:*
 - [\<nix-chad/modules/chad/browser\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/browser.nix)



## chad\.editor\.lineNumbering



Absolute: line numbers counted from the beginning of the document
Relative: line numbers counted from the current cursor position



*Type:*
one of “absolute”, “relative”



*Default:*
` "relative" `

*Declared by:*
 - [\<nix-chad/modules/chad/editor\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/editor.nix)



## chad\.extraPackages



Additional nixpkgs packages to be accessible for the user\.



*Type:*
null or (function that evaluates to a(n) list of package)



*Default:*
` null `



*Example:*

```
pkgs: with pkgs; [ cowsay ];

```

*Declared by:*
 - [\<nix-chad/modules/chad/default\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/default.nix)



## chad\.fontSize



A desired font size in tools that have means to set it fixed\.



*Type:*
signed integer



*Default:*
` 12 `



*Example:*
` 16 `

*Declared by:*
 - [\<nix-chad/modules/chad/default\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/default.nix)



## chad\.gpg\.defaultKey



An ID of a key to be used for GPG signing by default\.
This is expected to be different for individuals\.
The key is not part of this repository and has to be provided
manually\.



*Type:*
null or string



*Default:*
` null `



*Example:*
` "BE318F09150F6CB0724FFEC0319EE1D7FC029354" `

*Declared by:*
 - [\<nix-chad/modules/chad/gpg\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/gpg.nix)



## chad\.keyboard\.disableKeyRepeat



Holding keys does not make characters being typed repeatedly\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/keyboard.nix)



## chad\.keyboard\.remapCapsLock



Treat Caps Lock key as Escape key\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/keyboard.nix)



## chad\.keyboard\.remapLeftArrow



Treat Left Arrow key as Right Control key\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [\<nix-chad/modules/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/keyboard.nix)



## chad\.manageWindows\.enable



Keep windows occupy maximum available share of space on desktop\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [\<nix-chad/modules/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/manage-windows.nix)



## chad\.manageWindows\.exclusions



List of application names for which automatic
window management should not be performed\.
It can be figured out using this command:

```shell
  yabai -m query --windows
```



*Type:*
list of (submodule)



*Default:*
` [ ] `



*Example:*

```
[
  {
    app = "^Discord$";
    title = ".*Dialog$";
  }
]
```

*Declared by:*
 - [\<nix-chad/modules/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/manage-windows.nix)



## chad\.manageWindows\.exclusions\.\*\.app



Regex for application name\.



*Type:*
string



*Example:*
` "^Discord$" `

*Declared by:*
 - [\<nix-chad/modules/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/manage-windows.nix)



## chad\.manageWindows\.exclusions\.\*\.title



Regex for window title\.



*Type:*
string



*Default:*
` ".*" `



*Example:*
` ".*Dialog$" `

*Declared by:*
 - [\<nix-chad/modules/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/manage-windows.nix)



## chad\.mouse\.naturalScrollDirection



Should content scroll opposite to the swipe/roll direction\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/chad/mouse\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/mouse.nix)



## chad\.terminal\.abbreviations



An attribute set that maps aliases (the top level attribute names
in this option) to abbreviations\. Abbreviations are expanded with
the longer phrase after they are entered\.



*Type:*
attribute set of string



*Default:*
` { } `



*Example:*

```
{
  gco = "git checkout";
  l = "less";
}
```

*Declared by:*
 - [\<nix-chad/modules/chad/terminal\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/terminal.nix)



## chad\.terminal\.keyBindings



Additional key bindings for terminal emulator\.



*Type:*
list of (submodule)



*Default:*
` [ ] `



*Example:*

```
[
  {
    chars = "\\u000c";
    key = "K";
    mods = "Control";
  }
]
```

*Declared by:*
 - [\<nix-chad/modules/chad/terminal\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/terminal.nix)



## chad\.terminal\.keyBindings\.\*\.chars



Substitution\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad/terminal\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/terminal.nix)



## chad\.terminal\.keyBindings\.\*\.key



Key\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad/terminal\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/terminal.nix)



## chad\.terminal\.keyBindings\.\*\.mods



Modifier key(s)\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad/terminal\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/terminal.nix)



## chad\.terminal\.zshInitExtra



Additional initialization for ZSH sessions\.



*Type:*
strings concatenated with “\\n”



*Default:*
` "" `



*Example:*

```
''
  export VAR1=val1  
  export VAR2=val2
''
```

*Declared by:*
 - [\<nix-chad/modules/chad/terminal\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/terminal.nix)



## chad\.user\.homeDirectories



A list of desirect directories to be created in the home
directory of the user\.
It is up to the user to provide the contents of these
directories\.



*Type:*
list of string



*Default:*
` [ ] `



*Example:*

```
[
  "Development/exercises"
  "Development/presentations"
  "Development/projects"
]
```

*Declared by:*
 - [\<nix-chad/modules/chad/user\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/user.nix)



## chad\.user\.name



User name\.



*Type:*
string



*Example:*
` "bob" `

*Declared by:*
 - [\<nix-chad/modules/chad/user\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad/user.nix)


