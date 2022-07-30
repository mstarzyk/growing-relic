{ stdenv, bundlerEnv, ... }:

let
  env = bundlerEnv {
    name = "gems-for-growing-relic";
    gemdir = ./.;
    gemset = ./gemset.nix;
    groups = ["default" "development" "production" "test"];
  };

  app = stdenv.mkDerivation {
    pname = "growing-relic";
    version = "0.0.1";

    src = ./.;

    buildInputs = [
      env
      env.wrappedRuby
    ];

    env = env;

    installPhase = ''
      mkdir -p $out
      cp -a . $out
      '';
    };
in {
  env = env;
  app = app;
}
