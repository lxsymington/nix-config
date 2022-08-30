{ inputs, config, pkgs, ... }:
let
  prefix = "/run/current-system/sw/bin";
  inherit (pkgs.stdenvNoCC) isAarch64 isAarch32;
in {
  environment = {
    etc = {
      darwin.source = "${inputs.darwin}"; 
    };
    variables = {
      SHELL = "${pkgs.fish}/bin/fish";
      TERMINFO_DIRS =
        "${pkgs.ncurses.outPath}/share/terminfo:${pkgs.alacritty.terminfo.outPath}/share/terminfo";
    };

    systemPackages = with pkgs; [
      # GUI applications
      alacritty
      # brave
      emacs
      # mongodb-compass
      postman
      pritunl-ssh
      # slack
      teams

      # Global utils
      fd
      fzf
      ncurses
      nix-prefetch-git
      ripgrep
    ];
  
    pathsToLink = [
      "/Applcations"
      "/share/doc"
      "/share/terminfo"
    ];
  };

  nix.nixPath = [ "darwin=/etc/${config.environment.etc.darwin.target}" ];

  # auto manage nixbld users with nix darwin
  nix.configureBuildUsers = true;

  services.activate-system.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
