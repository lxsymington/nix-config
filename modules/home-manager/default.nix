{ self, inputs, config, pkgs, ... }:

let
  assume-role = builtins.fetchGit {
    url = "git@github.com:ibisnetworks/assume-role.git";
    ref = "master";
    rev =  "b59b398b6c197eb2442a13cf8afe08936501b881";
  };
  GOPATH = "go";
  GOBIN = "${GOPATH}/bin";
in
{
  manual.manpages.enable = true;

  home = {
    packages = with pkgs; [
      _1password
      ansible
      aws-sam-cli
      awscli
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
      jq
      imagemagick
      inetutils
      llvm
      mongodb-tools
      mongosh
      multimarkdown
      neovim
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
      renix = "darwin-rebuild switch --flake ~/.config/nixpkgs";
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
      AUTO_OPS = "${config.home.homeDirectory}/.seccl/auto-ops";
      AWS_PROFILE = "seccl-master";
      CORE_ENV = "genshared";
      STAGE_ENV = "devlsymington";
      EDITOR = "nvim";
      HOMEBREW_CELLAR = /opt/homebrew/Cellar;
      HOMEBREW_PREFIX = /opt/homebrew;
      HOMEBREW_REPOSITORY = /opt/homebrew;
      MANPAGER = "nvim +Man!";
      # Required for AUTO_OPS first time setup
      NVM_DIR = "${config.home.homeDirectory}/.nvm";
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
      packages = {
        "github.com/ibisnetworks/assume-role" = assume-role;
      };
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
      languages = [
        {
          name = "nix";
          file-types = ["nix"];
          comment-token = "#";
          auto-format = true;
          language-server = {
            command = "${pkgs.rnix-lsp}/bin/nil";
          };
        }
      ];
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
