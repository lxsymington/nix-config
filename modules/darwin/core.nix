{ inputs, config, pkgs, ... }:
{
  environment = {
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
      pinentry = "pinentry-touchid";
      renix = "darwin-rebuild switch --flake ${config.environment.darwinConfig}";
    };

    systemPackages = with pkgs; [
      alacritty
      ncurses
      reattach-to-user-namespace
    ];

    variables = {
      SHELL = "${pkgs.fish}/bin/fish";
      TERMINFO_DIRS = [
        "$HOME/.local/share/terminfo"
        "/run/current-system/sw/share/terminfo"
      ];
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      recursive
      (nerdfonts.override { fonts = [ "JetBrainsMono" "CommitMono" ]; })
    ];
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
      "jorgelbg/tap"
    ];
    brews = [
      "pinentry"
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
