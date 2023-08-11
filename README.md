# Nix Chad

[![Release and deploy](https://github.com/mstream/nix-chad/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/mstream/nix-chad/actions/workflows/lint.yml?query=branch%3Amain)

![nix-chad logo](nix-chad.png)

An opinionated MacOS setup focused on software development.

## Features

### Neovim programming/configuration languages support

| language   | actions | completion | diagnostics | formatting | highlighting |
| :--------- | :-----: | :--------: | :---------: | :--------: | :----------: |
| bash       |    +    |     +      |      +      |     +      |      +       |
| dhall      |    -    |     +      |      +      |     +      |      +       |
| json       |    -    |     -      |      +      |     +      |      +       |
| javascript |    +    |     +      |      +      |     +      |      +       |
| lua        |    +    |     +      |      +      |     +      |      +       |
| markdown   |    -    |     -      |      +      |     +      |      +       |
| nix        |    -    |     -      |      +      |     +      |      +       |
| purescript |    +    |     +      |      +      |     +      |      +       |
| python     |    -    |     +      |      +      |     +      |      +       |
| typescript |    +    |     +      |      +      |     +      |      +       |
| yaml       |    +    |     -      |      +      |     +      |      +       |

## Prerequisites

- Nix 2.4+

## Configuration

### Initializing from a template

Run from a directory of your choice:

```bash
nix flake init --template github:mstream/nix-chad/main#default
```

### Tweaking

Update any config entries to your liking like in [this](test/flake.nix) example.

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
