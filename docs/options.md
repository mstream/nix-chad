## _module\.args

Additional arguments passed to each module in addition to ones
like ` lib `, ` config `,
and ` pkgs `, ` modulesPath `\.

This option is also available to all submodules\. Submodules do not
inherit args from their parent module, nor do they provide args to
their parent module or sibling submodules\. The sole exception to
this is the argument ` name ` which is provided by
parent modules to a submodule and contains the attribute name
the submodule is bound to, or a unique generated name if it is
not bound to an attribute\.

Some arguments are already passed by default, of which the
following *cannot* be changed with this option:

 - ` lib `: The nixpkgs library\.

 - ` config `: The results of all options after merging the values from all modules together\.

 - ` options `: The options declared in all modules\.

 - ` specialArgs `: The ` specialArgs ` argument passed to ` evalModules `\.

 - All attributes of ` specialArgs `
   
   Whereas option values can generally depend on other option values
   thanks to laziness, this does not apply to ` imports `, which
   must be computed statically before anything else\.
   
   For this reason, callers of the module system can provide ` specialArgs `
   which are available during import resolution\.
   
   For NixOS, ` specialArgs ` includes
   ` modulesPath `, which allows you to import
   extra modules from the nixpkgs package tree without having to
   somehow make the module aware of the location of the
   ` nixpkgs ` or NixOS directories\.
   
   ```
   { modulesPath, ... }: {
     imports = [
       (modulesPath + "/profiles/minimal.nix")
     ];
   }
   ```

For NixOS, the default value for this option includes at least this argument:

 - ` pkgs `: The nixpkgs package set according to
   the ` nixpkgs.pkgs ` option\.



*Type:*
lazy attribute set of raw value

*Declared by:*
 - [\<nixpkgs/lib/modules\.nix>](https://github.com/NixOS/nixpkgs/blob//lib/modules.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.browser\.bookmarks\.\*\.title



Title of the bookmark\.



*Type:*
string

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.browser\.bookmarks\.\*\.url



URL of the bookmark\.



*Type:*
string

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.fontSize



A desired font size in tools that have means to set it fixed\.



*Type:*
signed integer



*Default:*
` 12 `



*Example:*
` 16 `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.keyboard\.remapCapsLock



Treat Caps Lock key as Escape key\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.keyboard\.remapLeftArrow



Treat Left Arrow key as Right Control key\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.manageWindows\.enable



Keep windows occupy maximum available share of space on desktop\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.manageWindows\.exclusions\.\*\.app



Regex for application name\.



*Type:*
string



*Example:*
` "^Discord$" `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.manageWindows\.exclusions\.\*\.title



Regex for window title\.



*Type:*
string



*Default:*
` ".*" `



*Example:*
` ".*Dialog$" `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.terminal\.keyBindings



Additonal key bindings for terminal emulator\.



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.terminal\.keyBindings\.\*\.chars



Substitution\.



*Type:*
string

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.terminal\.keyBindings\.\*\.key



Key\.



*Type:*
string

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.terminal\.keyBindings\.\*\.mods



Modifier key(s)\.



*Type:*
string

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



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
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)



## chad\.user\.name



User name\.



*Type:*
string



*Example:*
` "bob" `

*Declared by:*
 - [/nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad\.nix](file:///nix/store/mrlwlvxy1m2kl7q37zmnnv49gfqzi4dl-source/modules/chad.nix)


