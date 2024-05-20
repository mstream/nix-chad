## chad\.browser\.bookmarks

Browser bookmarks\.
Not supported until there is a nix-native browser for
Apple Silicon available\.



*Type:*
list of (submodule)



*Default:*
` [ ] `



*Example:*

```
[
  {
    title = "Nix Chad";
    url = "https://github.com/mstream/nix-chad";
  }
]
```

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.browser\.bookmarks\.\*\.title



Title of the bookmark\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.browser\.bookmarks\.\*\.url



URL of the bookmark\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.fontSize



A desired font size in tools that have means to set it fixed\.



*Type:*
signed integer



*Default:*
` 12 `



*Example:*
` 16 `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.keyboard\.remapCapsLock



Treat Caps Lock key as Escape key\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.keyboard\.remapLeftArrow



Treat Left Arrow key as Right Control key\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.manageWindows\.enable



Keep windows occupy maximum available share of space on desktop\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.manageWindows\.exclusions\.\*\.app



Regex for application name\.



*Type:*
string



*Example:*
` "^Discord$" `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.manageWindows\.exclusions\.\*\.title



Regex for window title\.



*Type:*
string



*Default:*
` ".*" `



*Example:*
` ".*Dialog$" `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.terminal\.keyBindings\.\*\.chars



Substitution\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.terminal\.keyBindings\.\*\.key



Key\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.terminal\.keyBindings\.\*\.mods



Modifier key(s)\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



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
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)



## chad\.user\.name



User name\.



*Type:*
string



*Example:*
` "bob" `

*Declared by:*
 - [\<nix-chad/modules/chad\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/chad.nix)


