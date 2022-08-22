{ config, pkgs, ... }:

let main_user = "lukexaviersymington";
in {
  environment.variables = {
    SHELL = "${pkgs.fish}/bin/fish";
    TERMINFO_DIRS =
        "${pkgs.alacritty.terminfo.outPath}/share/terminfo";
  };

  environment.systemPackages = with pkgs; [
    # GUI applications
    alacritty
    # brave
    emacs
    # mongodb-compass
    postman
    # slack

    # Global utils
    fd
    fzf
    nix-prefetch-git
    ripgrep
  ];
  
  environment.shells = with pkgs; [ fish ];

  environment.pathsToLink = [
    "/share/doc/"
  ];

  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  users.users.${main_user}= {
    name = main_user;
    description = "Luke Xavier Symington";
    home = "/Users/${main_user}";
    shell = pkgs.fish;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.package = pkgs.nixUnstable;
  nix.trustedUsers = [ "root" "lukexaviersymington" ];
  nix.allowedUsers = [ "root" "lukexaviersymington" ];
  nix.extraOptions = "experimental-features = nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  programs.nix-index.enable = true;
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      completions.enable = true;
      functions.enable = true;
    };
  };
  programs.man.enable = true;
  programs.tmux = {
    enable = true;
    enableSensible = true;
    enableMouse = true;
    enableFzf = true;
    enableVim = true;
  };
  programs.vim = {
    enable = true;
    enableSensible = true;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  services.activate-system.enable = true;

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
