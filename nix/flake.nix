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
              growing-relic = final.callPackage ./app/growing-relic {};
              rails = final.callPackage ./pkgs/rails {};
            })
          ];
        };
      in rec {
        devShells = flake-utils.lib.flattenTree rec {
          bootstrap = pkgs.mkShell {
            packages = [
              pkgs.bundix
              packages.rails
            ];
          };

          env2 = pkgs.mkShell {
             packages = [
               packages.growing-relic
               # packages.growing-relic.wrappedRuby
             ];
          };

          default = bootstrap;
        };

        packages = flake-utils.lib.flattenTree rec {
          hello = pkgs.hello;
          rails = pkgs.rails;
          growing-relic = pkgs.growing-relic.app;
          default = growing-relic;
        };

        # checks = TODO

        # apps = rec {
        #   hello = flake-utils.lib.mkApp {
        #     drv = packages.hello;
        #   };
        #   default = hello;
        # };
      });
}
