{ inputs, config, pkgs, ... }:
{
  environment = {
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
    
    systemPackages = with pkgs; [
      # GUI applications
      alacritty
      direnv

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
    ];
    brews = [
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
  };

  services = {
    activate-system.enable = true;
    nix-daemon.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
