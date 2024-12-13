{ homeDirectory
, hostname
, inputs
, pkgs
, self
, username
, ...
}: {
  imports = [ ./primary.nix ./nixpkgs.nix ];

  documentation = {
    man.enable = true;
  };

  # environment setup
  environment = {
    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${pkgs.path}";
      stable.source = "${inputs.nixpkgs-stable}";
    };

    pathsToLink = [ "/share/fish" ];

    # list of acceptable shells in /etc/shells
    shells = with pkgs; [ bash zsh fish ];

    systemPackages = with pkgs; [
      # standard toolset
      uutils-coreutils-noprefix
      curl
      wget

      # nix utils
      nixpkgs-fmt

      # editor
      lxs-nvim

      # helpful shell stuff
      act
      ast-grep
      atac
      gojq
      just
      inputs.mergiraf
    ];
  };

  # bootstrap home manager using system config
  hm = import ./home-manager;

  # let nix manage home-manager profiles and use global nixpkgs
  home-manager = {
    extraSpecialArgs = { inherit self homeDirectory hostname inputs username; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  networking = {
    hostName = hostname;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  programs = {
    fish = {
      enable = true;
      vendor = {
        config.enable = true;
        completions.enable = true;
        functions.enable = true;
      };
    };

    tmux = {
      enable = true;
    };
  };

  user = {
    name = username;
    description = "Luke Xavier Symington";
    home = homeDirectory;
    shell = pkgs.fish;
  };
}
