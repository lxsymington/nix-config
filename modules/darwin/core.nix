{
  inputs,
  config,
  pkgs,
  ...
}: {
  environment = {
    darwinConfig = "~/.config/nix-darwin";

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
      renix = "darwin-rebuild switch --flake ${config.environment.darwinConfig}";
    };

    systemPackages = with pkgs; [
      alacritty
      ncurses
      reattach-to-user-namespace
      volta
    ];

    systemPath = [
      "$HOMEBREW_REPOSITORY/bin"
      "$HOMEBREW_REPOSITORY/sbin"
    ];

    variables = {
      HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
      HOMEBREW_PREFIX = "/opt/homebrew";
      HOMEBREW_REPOSITORY = "/opt/homebrew";
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
      "docker"
      "ghostty"
      "mongodb-compass"
      "neovide"
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    primaryUser = "lxs";
    stateVersion = 4;
  };
}
