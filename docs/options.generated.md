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
 - [\<nix-chad/modules/darwin/chad/browser\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/browser.nix)



## chad\.browser\.extraExtensions



Additional Firefox extensions to be installed for the user\.



*Type:*
null or (function that evaluates to a(n) list of package)



*Default:*
` null `



*Example:*

```
exts: with exts; [ grammarly ];

```

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/browser\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/browser.nix)



## chad\.editor\.documentWidth



Ideal maximum document’s width measured in number of characters\.



*Type:*
signed integer



*Default:*
` 72 `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.close\.suffixes\.currentBuffer



close the current buffer



*Type:*
string



*Default:*
` "bc" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.addEndOfLine



add at the end of line



*Type:*
string



*Default:*
` "lA" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.addLineAbove



add line above



*Type:*
string



*Default:*
` "lO" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.addLineBelow



add line below



*Type:*
string



*Default:*
` "lo" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.block



block operator-pending



*Type:*
string



*Default:*
` "b" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.line



line operator-pending



*Type:*
string



*Default:*
` "l" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.toggleBlock



toggle block



*Type:*
string



*Default:*
` "tb" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.comment\.suffixes\.toggleLine



toggle line



*Type:*
string



*Default:*
` "tl" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.codeDefinitions



code definitions



*Type:*
string



*Default:*
` "cd" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.codeImplementations



code implementations



*Type:*
string



*Default:*
` "ci" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.codeReferences



code references



*Type:*
string



*Default:*
` "cr" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.codeTypeDefinitions



code type definitions



*Type:*
string



*Default:*
` "ct" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.files



files



*Type:*
string



*Default:*
` "f" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.gitBranches



Git branches



*Type:*
string



*Default:*
` "gb" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.gitCommits



Git commits



*Type:*
string



*Default:*
` "gc" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.gitLocalChanges



Git local changes



*Type:*
string



*Default:*
` "gl" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.gitStash



Git stashed changes



*Type:*
string



*Default:*
` "gs" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.implementations



implementations



*Type:*
string



*Default:*
` "i" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.vimBuffers



Vim buffers



*Type:*
string



*Default:*
` "vb" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.vimCommands



Vim commands



*Type:*
string



*Default:*
` "vc" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.vimHelp



Vim help topics



*Type:*
string



*Default:*
` "vh" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.find\.suffixes\.words



words across files



*Type:*
string



*Default:*
` "w" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.goTo\.suffixes\.declaration



declaration



*Type:*
string



*Default:*
` "D" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.goTo\.suffixes\.definition



definition



*Type:*
string



*Default:*
` "d" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.goTo\.suffixes\.implementation



implementation



*Type:*
string



*Default:*
` "i" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.goTo\.suffixes\.nextProblem



next problem



*Type:*
string



*Default:*
` "]" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.goTo\.suffixes\.previousProblem



previous problem



*Type:*
string



*Default:*
` "[" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.refactor\.suffixes\.action



action



*Type:*
string



*Default:*
` "a" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.refactor\.suffixes\.format



format



*Type:*
string



*Default:*
` "f" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.refactor\.suffixes\.name



name



*Type:*
string



*Default:*
` "n" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.select\.suffixes\.decrement



decrement selection



*Type:*
string



*Default:*
` "d" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.select\.suffixes\.increment



increment selection



*Type:*
string



*Default:*
` "i" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.categorized\.select\.suffixes\.initialize



initialize selection



*Type:*
string



*Default:*
` "s" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.cancel



Cancel current selection or mode



*Type:*
string



*Default:*
` "<ESC>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.confirm



Confirm current selection



*Type:*
string



*Default:*
` "<CR>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.jumpToNextDiagnostic



Jump to a line with the next diagnostic message



*Type:*
string



*Default:*
` "]d" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.jumpToPreviousDiagnostic



Jump to a line with the previous diagnostic message



*Type:*
string



*Default:*
` "[d" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.moveToBottomWindow



Move to window on the bottom



*Type:*
string



*Default:*
` "<C-j>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.moveToLeftWindow



Move to window on the left



*Type:*
string



*Default:*
` "<C-h>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.moveToRightWindow



Move to window on the right



*Type:*
string



*Default:*
` "<C-l>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.moveToTopWindow



Move to window on the top



*Type:*
string



*Default:*
` "<C-k>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.scrollDown



Sroll content down (half a page)



*Type:*
string



*Default:*
` "<C-d>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.scrollDownFullPage



Sroll content down (full page)



*Type:*
string



*Default:*
` "<C-f>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.scrollUp



Scroll content up (half a page)



*Type:*
string



*Default:*
` "<C-u>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.scrollUpFullPage



Scroll content up (full page)



*Type:*
string



*Default:*
` "<C-b>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.selectNext



Select next item on a list



*Type:*
string



*Default:*
` "<C-n>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.selectPrevious



Select previous item on a list



*Type:*
string



*Default:*
` "<C-p>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.showKeyMappings



Show key mappings



*Type:*
string



*Default:*
` "\\" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.showSymbolInfo



Show information about the symbol under the cursor



*Type:*
string



*Default:*
` "K" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.switchToNextTab



switch to next tab



*Type:*
string



*Default:*
` "<TAB>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.keyMappings\.uncategorized\.switchToPreviousTab



switch to previous tab



*Type:*
string



*Default:*
` "<S-TAB>" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.lineNumbering



Absolute: line numbers counted from the beginning of the document
Relative: line numbers counted from the current cursor position



*Type:*
one of “absolute”, “relative”



*Default:*
` "relative" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



## chad\.editor\.tabWidth



Tabulation width measured in number of characters\.



*Type:*
signed integer



*Default:*
` 2 `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/editor>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/editor)



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
 - [\<nix-chad/modules/darwin/chad>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad)



## chad\.fontSize



A desired font size in tools that have means to set it fixed\.



*Type:*
signed integer



*Default:*
` 12 `



*Example:*
` 16 `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad)



## chad\.git\.alternativeGitIdentities



Alternative Git identities for selected repositories\.



*Type:*
list of (submodule)



*Default:*
` [ ] `



*Example:*

```
[
  {
    repositoryPath = "~/work/project-1";
    sshKeyPath = "~/.ssh/work_id_rsa";
    userEmail = "me@mail.com";
  }
]
```

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/git\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/git.nix)



## chad\.git\.alternativeGitIdentities\.\*\.repositoryPath



Git repository path\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/git\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/git.nix)



## chad\.git\.alternativeGitIdentities\.\*\.sshKeyPath



Path to a SSH private key\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/git\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/git.nix)



## chad\.git\.alternativeGitIdentities\.\*\.userEmail



Key\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/git\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/git.nix)



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
 - [\<nix-chad/modules/darwin/chad/gpg\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/gpg.nix)



## chad\.keyboard\.disableKeyRepeat



Holding keys does not make characters being typed repeatedly\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/keyboard.nix)



## chad\.keyboard\.remapCapsLock



Treat Caps Lock key as Escape key\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/keyboard.nix)



## chad\.keyboard\.remapLeftArrow



Treat Left Arrow key as Right Control key\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/keyboard.nix)



## chad\.keyboard\.shortcuts



A set of macOS desktop-level shortcuts\.



*Type:*
attribute set of (submodule) *(read only)*



*Default:*

```
{
  screenshot = {
    modifierKeys = [
      "command"
      "shift"
    ];
    otherKey = "S";
  };
}
```

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/keyboard.nix)



## chad\.keyboard\.shortcuts\.\<name>\.modifierKeys



A list of modifier keys\.



*Type:*
list of (one of “command”, “control”, “option”, “shift”) *(read only)*



*Example:*

```
[
  "command"
  "shift"
]
```

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/keyboard.nix)



## chad\.keyboard\.shortcuts\.\<name>\.otherKey



A non-modifier key\.



*Type:*
one of “0”, “1”, “2”, “3”, “4”, “5”, “6”, “7”, “8”, “9”, “A”, “B”, “C”, “D”, “E”, “F”, “G”, “H”, “I”, “J”, “K”, “L”, “M”, “N”, “O”, “P”, “Q”, “R”, “S”, “T”, “U”, “V”, “W”, “X”, “Y”, “Z” *(read only)*



*Example:*
` "S" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/keyboard\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/keyboard.nix)



## chad\.manageWindows\.enable



Keep windows occupy maximum available share of space on desktop\.
Uses own emulation of multiple desktops/spaces\.



*Type:*
boolean



*Default:*
` false `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/manage-windows.nix)



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
 - [\<nix-chad/modules/darwin/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/manage-windows.nix)



## chad\.manageWindows\.exclusions\.\*\.app



Regex for application name\.



*Type:*
string



*Example:*
` "^Discord$" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/manage-windows.nix)



## chad\.manageWindows\.exclusions\.\*\.title



Regex for window title\.



*Type:*
string



*Default:*
` ".*" `



*Example:*
` ".*Dialog$" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/manage-windows\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/manage-windows.nix)



## chad\.mouse\.naturalScrollDirection



Should content scroll opposite to the swipe/roll direction\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/mouse\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/mouse.nix)



## chad\.software\.openSourceOnly



Restricts software to Open Source only\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/software\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/software.nix)



## chad\.terminal\.abbreviations\.enable



Enables expandable command abbreviations\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



## chad\.terminal\.abbreviations\.extraAbbreviations



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
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



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
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



## chad\.terminal\.keyBindings\.\*\.chars



Substitution\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



## chad\.terminal\.keyBindings\.\*\.key



Key\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



## chad\.terminal\.keyBindings\.\*\.mods



Modifier key(s)\.



*Type:*
string

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



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
 - [\<nix-chad/modules/darwin/chad/terminal>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/terminal)



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
 - [\<nix-chad/modules/darwin/chad/user\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/user.nix)



## chad\.user\.name



User name\.



*Type:*
string



*Example:*
` "bob" `

*Declared by:*
 - [\<nix-chad/modules/darwin/chad/user\.nix>](https://github.com/mstream/nix-chad/blob/main/modules/darwin/chad/user.nix)


