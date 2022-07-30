# { stdenv, rails, ... }:

# stdenv.mkDerivation rec {
#   src = ./.;
#
#   name = "growing-relic";
#
#   buildInputs = [ rails ];
#
#   installPhase = ''
#     mkdir -p $out
#     rails new $out --api --skip-active-record
#     cd $out
#     rails g resource post
#     install -D "$src/app/controllers/posts_controller.rb" \
#                "$out/app/controllers"
#   '';
# }

{ bundlerEnv, ... }:

bundlerEnv {
  name = "gems-for-growing-relic";
  gemdir = ./.;
}
