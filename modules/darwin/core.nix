{
  self,
  inputs,
  config,
  username,
  pkgs,
  ...
}: let
  homebrewRepository = "/opt/homebrew";
in {
  environment = {
    darwinConfig = "~/.config/nix-darwin";

    etc = {
      darwin.source = "${inputs.darwin}";
    };

    pathsToLink = [
      "/Applications"
      "/share/doc"
      "/share/terminfo"
    ];

    shellAliases = {
      renix = "sudo darwin-rebuild switch --flake ${config.environment.darwinConfig}";
    };

    systemPackages = with pkgs; [
      alacritty
      ncurses
      reattach-to-user-namespace
      volta
    ];

    systemPath = [
      "${homebrewRepository}/bin"
      "${homebrewRepository}/sbin"
    ];

    variables = {
      CARAPACE_BRIDGES = "bash,fish,zsh";
      HOMEBREW_CELLAR = "${homebrewRepository}/Cellar";
      HOMEBREW_PREFIX = homebrewRepository;
      HOMEBREW_REPOSITORY = homebrewRepository;
      SHELL = "${pkgs.fish}/bin/fish";
      TERMINFO_DIRS = [
        "$HOME/.local/share/terminfo"
        "/run/current-system/sw/share/terminfo"
      ];
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.commit-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.recursive-mono
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
    casks = [
      "docker-desktop"
      "ghostty"
      "mongodb-compass"
      "postman"
    ];
  };

  nix.nixPath = ["darwin=/etc/${config.environment.etc.darwin.target}"];

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  system = {
    primaryUser = username;
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
  };
}
