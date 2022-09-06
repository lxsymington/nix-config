# Personal Nix Config

Using [`nix-darwin`](https://github.com/LnL7/nix-darwin) and
[`home-manager`](https://github.com/nix-community/home-manager) 

```
darwin-rebuild switch --flake ~/.config/nixpkgs
```

### Useful learnings

Use `nix-prefetch-git` to get information about git repositories that will be useful for
configuration. 

### Notes

Programs/Applications not currently managed via Nix

 - Slack
 - MongoDB Compass
 - Brave Browser
 - PriTunl
