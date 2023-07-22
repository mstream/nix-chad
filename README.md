# Nix Chad

![nix-chad logo](nix-chad.png)

An opinionated MacOS setup focused on software development.

## Prerequisites

- Nix 2.4+

## Configuring

### Intializing from a template

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

          # Install homebrew and let it manage propertiary software.
          manageHomebrew = true;

          # This should be set to the desired user name.
          username = "my-user";
        };
    in
    nix-chad.lib.chad config;
}
```

## Running

Run from the directory where `flake.nix` file resides:

```bash
nix run .#switch
```
