{
  description = "Argos";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, flake-utils, devshell, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [ devshell.overlays.default ];

          config.permittedInsecurePackages = [ ];
        };
      in pkgs.devshell.mkShell {
        name = "argos.dev";
        packages = [
          pkgs.pkg-config
          pkgs.gcc
          pkgs.sqlite
          pkgs.gnumake
          pkgs.go
          pkgs.delve
          pkgs.goa
          pkgs.protobuf
          pkgs.protoc-gen-go
          pkgs.protoc-gen-go-grpc
          pkgs.libyaml.dev
          pkgs.openssl_3_2.dev
          pkgs.postgresql_16.dev
          pkgs.autoconf269
          pkgs.automake
          pkgs.autogen
          pkgs.libtool
          pkgs.libffi.dev
          pkgs.gnum4
          pkgs.secp256k1
        ];
        env = [
          {
            name = "PKG_CONFIG_PATH";
            value =
              "${pkgs.pkg-config}:${pkgs.openssl_3_2.dev}/lib/pkgconfig:${pkgs.libyaml.dev}/lib/pkgconfig:${pkgs.postgresql_16.dev}/lib/pkgconfig:${pkgs.libffi.dev}/lib/pkgconfig:${pkgs.secp256k1}/lib/pkgconfig";
          }
          {
            name = "LIBTOOL";
            value = "${pkgs.libtool}";
          }
          {
            name = "NIXPKGS_ALLOW_INSECURE";
            value = "1";
          }
        ];
        commands = [
          {
            name = "install";
            category = "devshell";
            help = "Install all dependencies";
            command = "make install";
          }
          {
            name = "update";
            category = "devshell";
            help = "Update dependencies";
            command = "make update";
          }
          {
            name = "clean";
            category = "devshell";
            help = "Remove build artifacts";
            command = "make clean";
          }
          {
            name = "lint";
            category = "devshell";
            help = "Check code style with golangci-lint";
            command = "make lint";
          }
          {
            name = "format";
            category = "devshell";
            help = "Format code with gofmt";
            command = "make format";
          }
          {
            name = "spec";
            category = "devshell";
            help = "Run specs";
            command = "make spec";
          }
          {
            name = "build";
            category = "devshell";
            help = "Build the Go binary";
            command = "make build";
          }
          {
            name = "run";
            category = "devshell";
            help = "Run the application";
            command = "make run";
          }
          {
            name = "tidy";
            category = "devshell";
            help = "Clean up go.mod and go.sum";
            command = "make tidy";
          }
          {
            name = "shell";
            category = "devshell";
            help = "Start an interactive shell";
            command = "make shell";
          }
          {
            name = "setup";
            category = "devshell";
            help = "Initialize project structure";
            command = "make setup";
          }
          {
            name = "recreate";
            category = "devshell";
            help = "Clean and reinstall dependencies";
            command = "make recreate";
          }
        ];
      };
    });
}
