{ inputs, config, pkgs, ... }:
{
  environment = {
    # TODO: use XDG config home
    darwinConfig = "~/.config/nix-darwin/flake.nix";

    etc = {
      darwin.source = "${inputs.darwin}";
      terminfo = {
        source = "${pkgs.ncurses}/share/terminfo";
      };
    };

    pathsToLink = [
      "/Applications"
      "/share/doc"
      "/share/terminfo"
    ];
    
    shellAliases = {
      pinentry = "pinentry-mac";
    };
    
    systemPackages = with pkgs; [
      # GUI applications
      alacritty

      # Global utils
      ncurses
    ];

    variables = {
      SHELL = "${pkgs.fish}/bin/fish";
      TERMINFO_DIRS = [
        "$HOME/.local/share/terminfo"
        "/run/current-system/sw/share/terminfo"
      ];
    };
  };
  
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
      lockfiles = false;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      "homebrew/core"
      "homebrew/cask"
      "jorgelbg/tap"
    ];
    brews = [
      "pinentry-mac"
      "pinentry-touchid"
      "volta"
    ];
    casks = [
      "mongodb-compass"
      "postman"
      "docker"
    ];
  };

  nix.nixPath = [ "darwin=/etc/${config.environment.etc.darwin.target}" ];

  # auto manage nixbld users with nix darwin
  nix.configureBuildUsers = true;

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    tmux = {
      enable = true;
      enableSensible = true;
      enableMouse = true;
      enableFzf = true;
      enableVim = true;
    };

    vim = {
      enable = true;
      enableSensible = true;
    };
  };

  services = {
    activate-system.enable = true;
    nix-daemon.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
