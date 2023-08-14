# Personal Nix Config

Using [`nix-darwin`](https://github.com/LnL7/nix-darwin) and
[`home-manager`](https://github.com/nix-community/home-manager) 

```
darwin-rebuild switch --flake ~/.config/nixpkgs
```

### Useful learnings

For MacOS [the hostname](https://apple.stackexchange.com/a/287775) must match
the name of the darwin configuration.

For first time setup make sure to read through the section on flakes in the
nix-darwin documentation.

Use `nix-prefetch-git` to get information about git repositories that will be
useful for configuration. 

### NodeJS
Node is currently a bit of a pain to use with Nix, especially when using global
private/scoped packages. Consequently, volta will be used to managed node
dependencies.

### Notes

Programs/Applications not currently managed via Nix

 - Slack
 - MongoDB Compass
 - Brave Browser
 - PriTunl
 - Docker
 - Volta*
