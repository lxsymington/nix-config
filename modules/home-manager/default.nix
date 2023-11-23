{ config, pkgs, homeDirectory, inputs, ... }:

let
  inherit (inputs.nix-index-database.hmModules) nix-index;
  GOPATH = "go";
  GOBIN = "${GOPATH}/bin";
in
{
  manual.manpages.enable = true;

  home = {
    packages = with pkgs; [
      _1password
      # ansible # An ansible test is failing during the build
      alejandra
      cachix
      curl
      deadnix
      delta
      du-dust
      emscripten
      fd
      figlet
      fx
      fzf
      gh
      glib
      go
      gojq
      gopls
      graphviz
      hurl
      imagemagick
      inetutils
      jd-diff-patch
      jq
      llvm
      lua
      lua52Packages.luacheck
      mongodb-tools
      mongosh
      multimarkdown
      nghttp2
      nix-prefetch-git
      nixfmt
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      pandoc
      pcre
      pinentry
      ripgrep
      rnix-lsp
      rustup
      shellcheck
      shellcheck
      statix
      sumneko-lua-language-server
      terminal-notifier
      typescript
      xh
      yarn
    ];

    inherit homeDirectory;

    stateVersion = "23.11";

    shellAliases = {
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
    nix-index
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

    bash.enable = true;

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

    broot = {
      enable = true;
      enableFishIntegration = true;
    };

    command-not-found = {
      enable = false;
    };

    eza = {
      enable = true;
      enableAliases = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
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
          file-types = [ "nix" ];
          comment-token = "#";
          auto-format = true;
          language-servers = {
            command = "${pkgs.rnix-lsp}/bin/nil";
          };
        }];
      };
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    nix-index-database = {
      comma.enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      # Seems to cause issues with `pinentry` on macOS
      # enableTransience = true;
    };

    tealdeer.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
