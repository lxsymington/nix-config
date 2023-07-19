{ inputs, config, pkgs, ... }:
{
  environment = {
    etc = {
      darwin.source = "${inputs.darwin}";
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
      pritunl-ssh
      teams

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
      "homebrew/cask-drivers"
    ];
    brews = [
      "ruby" # Required for AUTO_OPS
      "volta"
    ];
    casks = [
      "mongodb-compass"
      "postman"
      "docker"
      # "pritunl"
      "https://raw.githubusercontent.com/Homebrew/homebrew-cask/6bf26425d09c020c4accb5cb958112ead452e5fd/Casks/pritunl.rb" # Pritunl
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
