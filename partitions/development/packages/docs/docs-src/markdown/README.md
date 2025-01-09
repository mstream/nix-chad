# Nix Chad

[![Project Website](https://img.shields.io/badge/github%20pages-121013?style=for-the-badge&logo=github&logoColor=white)](https://mstream.github.io/nix-chad/)

______________________________________________________________________

![nix-chad logo](nix-chad.png)

An opinionated macOS setup focused on software development.

## Features

### Firefox

#### discoverable key mappings

After pressing `?` key a window enumerating all contextual key mappings
appears.

### Neovim

#### programming/configuration languages support

![nvim dhall example screenshot](nvim-dhall-example.png)

| language                | actions | completion | diagnostics | formatting | highlighting |
| :---------------------- | :-----: | :--------: | :---------: | :--------: | :----------: |
| bash                    | ☒       | ☑          | ☑           | ☑          | ☑            |
| dhall                   | ☒       | ☑          | ☑           | ☑          | ☑            |
| docker                  | ☒       | ☒          | ☑           | ☒          | ☑            |
| GitHub Actions workflow | ☑       | ☑          | ☑           | ☑          | ☑            |
| html                    | ☒       | ☑          | ☑           | ☑          | ☑            |
| java                    | ☒       | ☑          | ☑           | ☑          | ☑            |
| json                    | ☒       | ☑          | ☑           | ☑          | ☑            |
| javascript              | ☑       | ☑          | ☑           | ☑          | ☑            |
| lua                     | ☑       | ☑          | ☑           | ☑          | ☑            |
| markdown                | ☑       | ☑          | ☑           | ☑          | ☑            |
| nix                     | ☒       | ☑          | ☑           | ☑          | ☑            |
| purescript              | ☑       | ☑          | ☑           | ☑          | ☑            |
| python                  | ☑       | ☑          | ☑           | ☑          | ☑            |
| typescript              | ☑       | ☑          | ☑           | ☑          | ☑            |
| yaml                    | ☑       | ☒          | ☑           | ☑          | ☑            |

#### discoverable key mappings

After pressing `\` key a window enumerating all key mappings appears.
The same window shows when user starts but does not finish a key
sequence which has some action assigned to it.

## Prerequisites

- [Nix 2.4+](https://nixos.org/manual/nix/stable/)

## Configuration

### Initializing from a template

Run from a directory of your choice:

```bash
nix flake init --template github:mstream/nix-chad/main#default
```

### Tweaking

Update any config entries to your liking, like in
[this](https://github.com/mstream/nix-chad/blob/main/examples/custom/flake.nix) example.

### Applying

After any change to configuration, run from the directory where
`flake.nix` file resides:

```bash
nix run .#switch
```

#### Warning

While it is easy to roll back unwanted/broken configuration by either
reverting your configuration changes or using a different `nix-chad`
flake revision, there are some classes of misconfigurations that are
more difficult to undo.

One of them is one that results in an error during ZSH shell
initialization. If that results in, e.g. `PATH` environmental variable
not being properly set, you may lose easy access to your binaries.

In this situation, to recover back to working state, you may need to:
- switch to Bash using an absolute binary path 
- use GUI tools (maybe enough to edit but not enough to rebuild Nix
  configuration)
- set `PATH` environmental variable manually (requires knowledge about 
  Nix)
- install needed binaries without nix (an overkill just for recovery)
- using absolute `nix store` paths (very fiddly)

None of these options are convenient and most of them require 
relatively broad administrative knowledge. Thus, **after every switch, 
it is highly recommended to:** 
- leave current shell session open,
- create a new one,
- observe if initialization scripts do not produce any errors,
- and if so, use the previous session to fix the issues

## Updating

To stay up-to-date witch changes to Nix Chad, run periodically:

```bash
nix flake update
```
