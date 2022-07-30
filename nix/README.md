# Resources

- [Nixpkgs Manual: Developing with Ruby](https://nixos.org/manual/nixpkgs/stable/#developing-with-ruby)
- [bundix](https://github.com/nix-community/bundix)


# Generate new rails project

```
nix-flakes develop .#bootstrap
mkdir -p app/growing-relic
cd app/growing-relic
rails new . --api --skip-bundle --skip-active-record
bundler lock
bundix
```

Now if you want to add this as a subdirectory of an existing git repo then
remove `.git/`.

Then continue:

```
git add .
```
