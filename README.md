# nix-darwin

This repository contains a Nix expression that installs necessary tools and configurations to make macOS adjust to my personal preferences.

## Pre-requisites

The only prerequisite is a Nix implementation

```sh
sh <(curl -L https://nixos.org/nix/install)
```

## Getting started

```sh
git clone https://github.com/jskswamy/nix-darwin.git ~/.config/nix-darwin
```

```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin
```
