{
  description = "Experiments with Rails and nginx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (final: prev: {
              growing-relic = final.callPackage ./pkgs/growing-relic {};
            })
          ];
        };
      in rec {
        devShells = flake-utils.lib.flattenTree rec {
          env = pkgs.mkShell {
            packages = [
              packages.growing-relic
              packages.growing-relic.wrappedRuby
            ];
          };

          env2 = pkgs.stdenv.mkDerivation {
            name = "env2";
            buildInputs = [
              pkgs.bundix
            ];
          };

          default = env;
        };

        packages = flake-utils.lib.flattenTree rec {
          hello = pkgs.hello;
          growing-relic = pkgs.growing-relic;
          default = growing-relic;
        };

        # checks = TODO

        apps = rec {
          hello = flake-utils.lib.mkApp {
            drv = packages.hello;
          };
          default = hello;
        };
      });
}
