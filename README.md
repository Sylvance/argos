# Argos

Golang project template using nix.

## Prerequisites

This template assumes you already have nix installed. If not, head over to https://github.com/DeterminateSystems/nix-installer
and come back after the installation is done.

- Nix. https://github.com/DeterminateSystems/nix-installer
- Direnv. https://github.com/direnv/direnv

## How to set it up

- Clone this repo and change into the root directory.
- `make setup`
- `direnv allow`

## How create a project from it

This template uses goa to generate project files.

- Ensure to rename this project from `argos` to your project name.
- Rename *ALL* instances of `argos` to your required project name.
- `make install`
- `make gen`
- `make implementation`
- `make run`

Then in another terminal
- `make example`
