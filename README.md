# Nix Chad

![nix-chad logo](nix-chad.png)

## Configuring

```nix
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

```sh
nix run github:mstream/nix-chad/main#switch
```
