{ self, inputs, config, pkgs, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "git@github.com:lxsymington/dotfiles.git";
    ref = "main";
    rev = "327698d20d33ecd7f5848004a5585b95027c409e";
  };
  build_alacritty_config = import ./alacritty.nix;
  build_fish_config = import ./fish.nix;
  build_git_config = import ./git.nix;
  build_tmux_config = import ./tmux.nix;
in
{
  manual.manpages.enable = true;

  home = {
    packages = with pkgs; [
      ansible
      aws-sam-cli
      awscli
      cachix
      cargo
      comma
      delta
      docker
      emscripten
      fd
      figlet
      glib
      go
      gojq
      imagemagick
      inetutils
      llvm
      lxs-neovim
      mongodb-tools
      mongosh
      multimarkdown
      nghttp2
      nix-index
      pandoc
      pcre
      pinentry
      pinentry_mac
      pritunl-ssh
      reattach-to-user-namespace
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
    # sessionVariables = {
    #   EDITOR = "nvim";
    #   MANPAGER = "nvim +Man!";
    # };
  };
  
  nixpkgs.config = {
    allowUnfree = true;
  };

  xdg.enable = true;
    
  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
    };
    alacritty = build_alacritty_config { inherit dotfiles config pkgs; };
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
    fish = build_fish_config { inherit dotfiles config pkgs; };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        editor = "${pkgs.vim}/bin/vim";
        pager = "${pkgs.delta}/bin/delta";
      };
    };
    git = build_git_config { inherit dotfiles config pkgs; };
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
      languages = [{
        name = "nix";
        file-types = ["nix"];
        comment-token = "#";
        language-server = {
          command = "${pkgs.rnix-lsp}/bin/nil";
        };
      }];
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    tealdeer.enable = true;
    tmux = build_tmux_config { inherit dotfiles config pkgs; };
    vscode = {
      enable = true;
      userSettings = {
        editor = {
          fontFamily = "JetBrainsMono Nerd Font";
          fontLigatures = true;
        };
        liveshare = {
          allowGuestTaskControl = true;
          allowGuestDebugControl = true;
          guestApprovalRequired = true;
          joinDebugSessionOption = "Prompt";
          languages = {
            allowGuestCommandControl = true;
          };
          launcherClient = "visualStudioCode";
          presence = true;
        };
        terminal = {
          external.osxExec = "Alacritty.app";
          explorerKind = "external";
          integrated = {
            localEchoStyle = "dim";
          };
        };
        testExplorer = {
          addToEditorContextMenu = true;
          mergeSuites = true;
          sort = "byLocation";
          useNativeTesting = true;
        };
        vim = {
          highlightedyank.enable = true;
          hlsearch = true;
          incsearch = true;
          insertModeKeyBindings = [
            {
              before = ["j" "j"];
              after = ["<Esc>"];
            }
          ];
          leader = "<space>";
          useCtrlKeys = true;
          useSystemClipboard = false;
        };
        window.zoomLevel = 1;
        workbench.colorTheme = "Catppuccin Latte";
      };
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "2.1.1";
          sha256 = "0x5gnzmn8mzqzf636jzqnld47mbbwml1ramiz290bpylbxvh553h";
        }
      ];
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
