{ self, inputs, config, pkgs, homeDirectory, username, ... }: {
  imports = [ ./primary.nix ./nixpkgs.nix ];

  programs = {
    nix-index.enable = true;
    bash.enable = true;
    zsh.enable = true;

    fish = {
      enable = true;
      vendor = {
        config.enable = true;
        completions.enable = true;
        functions.enable = true;
      };
    };

    man.enable = true;

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

  user = {
    name = username;
    description = "Luke Xavier Symington";
    home = homeDirectory;
    shell = pkgs.fish;
  };

  # bootstrap home manager using system config
  hm = import ./home-manager;

  # let nix manage home-manager profiles and use global nixpkgs
  home-manager = {
    extraSpecialArgs = { inherit self homeDirectory inputs username; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  # environment setup
  environment = {
    systemPackages = with pkgs; [
      # standard toolset
      coreutils-full
      curl
      wget
      git
      gojq

      # helpful shell stuff
      bat
      fzf
      ripgrep
    ];

    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${pkgs.path}";
      stable.source = "${inputs.stable}";
    };

    # list of acceptable shells in /etc/shells
    shells = with pkgs; [ bash zsh fish ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      recursive
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
