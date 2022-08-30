{ config, lib, pkgs, ... }: {
  user.name = "lukexaviersymington";
  hm = { imports = [ ./home-manager/lukexaviersymington-work.nix ]; };
}
