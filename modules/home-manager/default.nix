{ config, pkgs, ... }:

let
  GOPATH = "go";
  GOBIN = "${GOPATH}/bin";
in
{
  manual.manpages.enable = true;

  home = {
    packages = with pkgs; [
      _1password
      # ansible # An ansible test is failing during the build
      cachix
      cargo
      comma
      delta
      du-dust
      emscripten
      fd
      figlet
      fzf
      glib
      gojq
      graphviz
      hurl
      jq
      imagemagick
      inetutils
      llvm
      mongodb-tools
      mongosh
      multimarkdown
      nghttp2
      nix-index
      nix-prefetch-git
      pandoc
      pcre
      pinentry
      reattach-to-user-namespace
      ripgrep
      rnix-lsp
      shellcheck
      terminal-notifier
      xh
      yarn
    ];

    stateVersion = "22.11";

    shellAliases = {
      renix = "darwin-rebuild switch --flake ~/.config/nix-darwin";
      jq = "gojq";
    };

    sessionPath = [
      "$HOMEBREW_REPOSITORY/bin"
      "$HOMEBREW_REPOSITORY/sbin"
      "$VOLTA_HOME/bin"
      "${config.home.homeDirectory}/${GOBIN}"
      "${config.home.homeDirectory}/.seccl/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      HISTTIMEFORMAT = "%F %T ";
      HOMEBREW_CELLAR = /opt/homebrew/Cellar;
      HOMEBREW_PREFIX = /opt/homebrew;
      HOMEBREW_REPOSITORY = /opt/homebrew;
      MANPAGER = "nvim +Man!";
      VOLTA_HOME = "${config.home.homeDirectory}/.local/share/volta";
    };
  };
  
  nixpkgs.config = {
    allowUnfree = true;
  };

  xdg.enable = true;

  imports = [
    ./alacritty
    ./fish
    ./git
    ./neovim
    ./tmux
    ./vscode
  ];

  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
    };

    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        italic-text = "always";
        pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
        map-syntax = [ ".ignore:Git Ignore" ];
      };
    };

    bottom.enable = true;

    exa = {
      enable = true;
      enableAliases = true;
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        editor = "${pkgs.vim}/bin/vim";
        pager = "${pkgs.delta}/bin/delta";
      };
    };

    go = {
      enable = true;
      goBin = GOBIN;
      goPath = GOPATH;
    };

    gpg = {
      enable = true;
      settings = {
        utf8-strings = true;
        auto-key-locate = "local";
      };
    };

    helix = {
      enable = true;
      settings = {
      	editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        lsp.display-messages = true;
        };
        keys.normal = {
          space.space = "file_picker";
        };
      };
      languages = {
        language = [{
          name = "nix";
          file-types = ["nix"];
          comment-token = "#";
          auto-format = true;
          language-server = {
            command = "${pkgs.rnix-lsp}/bin/nil";
          };
        }];
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    tealdeer.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
