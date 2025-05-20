{
  homeDirectory,
  hostname,
  inputs,
  config,
  pkgs,
  self,
  username,
  ...
}: let
  theme = import ./colours.nix;
in {
  imports = [./primary.nix ./nixpkgs.nix];

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

    pathsToLink = ["/share/bash" "/share/fish" "/share/zsh" "/share/nushell"];

    # list of acceptable shells in /etc/shells
    shells = with pkgs; [bash zsh fish nushell];

    systemPackages = with pkgs; [
      # standard toolset
      uutils-coreutils-noprefix
      curl
      wget

      # nix utils
      nixpkgs-fmt

      # editor
      lxs-nvim
      zed-editor

      # helpful shell stuff
      act
      ast-grep
      atac
      dum
      gojq
      just
      inputs.mergiraf

      # AI agent
      goose-cli
    ];
  };

  # bootstrap home manager using system config
  hm = import ./home-manager;

  # let nix manage home-manager profiles and use global nixpkgs
  home-manager = {
    extraSpecialArgs = {inherit self homeDirectory hostname inputs username;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  networking = {
    hostName = hostname;
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
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

  stylix = {
    enable = true;
    autoEnable = true;
    fonts = {
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "NotoColorEmoji";
      };

      sansSerif = {
        package = pkgs.open-sans;
        name = "Open Sans";
      };

      serif = {
        package = pkgs.prociono;
        name = "Prociono";
      };

      monospace = {
        package = pkgs.nerd-fonts.commit-mono;
        name = "CommitMono Nerd Font Propo";
      };

      sizes = {
        applications = 12;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };

    image = config.lib.stylix.pixel "base0A";

    base16Scheme = {
      slug = "crepuscular-dawn";
      scheme = "Crepuscular Dawn";
      author = "lxsymington";
      variant = "dark";
      # Default Background
      base00 = theme {colour = "background";};
      # Lighter Background (Used for status bars, line number and folding marks)
      base01 = theme {
        colour = "blue";
        subVariant = "dim";
      };
      # Selection Background
      base02 = theme {
        colour = "purple";
        subVariant = "bright";
      };
      # Comments, Invisibles, Line Highlighting
      base03 = theme {colour = "grey";};
      # Dark Foreground (Used for status bars)
      base04 = theme {
        colour = "cyan";
        subVariant = "dim";
      };
      # Default Foreground, Caret, Delimiters, Operators
      base05 = theme {colour = "foreground";};
      # Light Foreground (Not often used)
      base06 = theme {
        colour = "yellow";
        subVariant = "dim";
      };
      # Light Background (Not often used)
      base07 = theme {
        colour = "purple";
        subVariant = "dim";
      };
      # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base08 = theme {
        colour = "red";
        subVariant = "bright";
      };
      # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base09 = theme {
        colour = "orange";
        subVariant = "bright";
      };
      # Classes, Markup Bold, Search Text Background
      base0A = theme {colour = "yellow";};
      # Strings, Inherited Class, Markup Code, Diff Inserted
      base0B = theme {
        colour = "green";
        subVariant = "bright";
      };
      # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0C = theme {colour = "cyan";};
      # Functions, Methods, Attribute IDs, Headings
      base0D = theme {
        colour = "blue";
        subVariant = "bright";
      };
      # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0E = theme {colour = "purple";};
      # Deprecated, Opening/Closing Embedded Language Tags, e.g.
      base0F = theme {
        colour = "orange";
        subVariant = "dim";
      };
    };
  };

  user = {
    name = username;
    description = "Luke Xavier Symington";
    home = homeDirectory;
    shell = pkgs.fish;
  };
}
