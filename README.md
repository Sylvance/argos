# Argos

Golang project template using nix

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
