{ bundlerEnv, ... }:

bundlerEnv {
  name = "gems-for-growing-relic";
  gemdir = ./.;
}
