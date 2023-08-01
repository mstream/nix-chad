# Nix Chad

![nix-chad logo](nix-chad.png)

An opinionated MacOS setup focused on software development.

## Features

### Neovim programming/configuration languages support

| language   | code actions | completion | diagnostics | formatting | syntax highlighting |
| :--------- | :----------: | :--------: | :---------: | :--------: | :-----------------: |
| bash       |      +       |     +      |      +      |     +      |          +          |
| dhall      |      -       |     +      |      +      |     +      |          +          |
| javascript |      +       |     +      |      +      |     +      |          +          |
| lua        |      +       |     +      |      +      |     +      |          +          |
| markdown   |      -       |     -      |      +      |     +      |          +          |
| nix        |      -       |     -      |      +      |     +      |          +          |
| purescript |      +       |     +      |      +      |     +      |          +          |
| python     |      -       |     +      |      +      |     +      |          +          |
| typescript |      +       |     +      |      +      |     +      |          +          |
| yaml       |      +       |     -      |      +      |     +      |          +          |

## Prerequisites

- Nix 2.4+

## Configuration

### Initializing from a template

Run from a directory of your choice:

```bash
nix flake init --template github:mstream/nix-chad/main#default
```

### Tweaking

Update any config entries to your liking:

```nix
# flake.nix
{
  description = "My Nix MacOS Environment";

  inputs = {
    nix-chad.url = "github:mstream/nix-chad/main";
  };

  outputs = { nix-chad, ... }:
    let
      config =
        {
          # An ID of a key to be used for GPG signing by default.
          # This is expected to be different for individuals.
          # The key is not part of this repository and has to be provided
          # manually.
          defaultGpgKey = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";

          # A desired font size in tools that have a mean to set it fixed.
          fontSize = 24;

          # A list of desired folders to be created in the home
          # directory of the user.
          # It's up to the user to provide the contents of these
          # directories.
          homeDirectories = [
            "Development/exercises"
            "Development/presentations"
            "Development/projects"
          ];

          # Install homebrew and let it manage proprietary software.
          manageHomebrew = true;

          # This should be set to the desired user name.
          username = "my-user";
        };
    in
    nix-chad.lib.chad config;
}
```

### Applying

After any change to configuration, run from the directory where
`flake.nix` file resides:

```bash
nix run .#switch
```

## Updating

To stay up to date witch changes to Nix Chad, run periodically:

```bash
nix flake update
```
