# Nix Chad

[![Release and deploy](https://github.com/mstream/nix-chad/actions/workflows/check.yml/badge.svg?branch=main)](https://github.com/mstream/nix-chad/actions/workflows/check.yml?query=branch%3Amain)

![nix-chad logo](nix-chad.png)

An opinionated MacOS setup focused on software development.

## Features

### Neovim programming/configuration languages support

![nvim dhall example screenshot](nvim-dhall-example.png)

| language   | actions | completion | diagnostics | formatting | highlighting |
| :--------- | :-----: | :--------: | :---------: | :--------: | :----------: |
| bash       |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| dhall      |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| docker     |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| html       |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| java       |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| json       |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| javascript |    ☑    |     ☑      |      ☑      |     ☑      |      ☑       |
| lua        |    ☑    |     ☑      |      ☑      |     ☑      |      ☑       |
| markdown   |    ☑    |     ☑      |      ☑      |     ☑      |      ☑       |
| nix        |    ☒    |     ☑      |      ☑      |     ☑      |      ☑       |
| purescript |    ☑    |     ☑      |      ☑      |     ☑      |      ☑       |
| python     |    ☑    |     ☑      |      ☑      |     ☑      |      ☑       |
| typescript |    ☑    |     ☑      |      ☑      |     ☑      |      ☑       |
| yaml       |    ☑    |     ☒      |      ☑      |     ☑      |      ☑       |

## Prerequisites

- [Nix 2.4+](https://nixos.org/manual/nix/stable/)

## Configuration

### Initializing from a template

Run from a directory of your choice:

```bash
nix flake init --template github:mstream/nix-chad/main#default
```

### Tweaking

Update any config entries to your liking like in
[this](examples/custom/flake.nix) example.

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
