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
      nodejs-slim-14_x
      nodePackages.npm
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
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
        # {
        #   name = "typescript";
        #   file-types = ["typescript"];
        #   comment-token = "//";
        #   auto-format = true;
        #   roots = ["package.json" "tsconfig.json" "jsconfig.json" ".git"];
        #   language-server = {
        #     command = "typescript-language-server";
        #     args = ["--stdio"];
        #   };
        # }
        # {
        #   name = "eslint";
        #   file-types = ["typescript" "javascript"];
        #   auto-format = true;
        #   roots = ["package.json" "tsconfig.json" "jsconfig.json" ".git"];
        #   language-server = {
        #     command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
        #     };
        # }
        # {
        #   name = "json";
        #   file-types = ["json"];
        #   auto-format = true;
        #   roots = [".git"];
        #   language-server = {
        #     command = "vscode-json-language-server";
        #     args = ["--stdio"];
        #   };
        # }
        # {
        #   name = "html";
        #   file-types = ["html"];
        #   auto-format = true;
        #   roots = [".git"];
        #   language-server = {
        #     command = "vscode-html-language-server";
        #     args = ["--stdio"];
        #   };
        # }
        # {
        #   name = "css";
        #   file-types = ["css"];
        #   auto-format = true;
        #   roots = [".git"];
        #   language-server = {
        #     command = "vscode-css-language-server";
        #     args = ["--stdio"];
        #   };
        # }
        # {
        #   name = "markdown";
        #   file-types = ["markdown"];
        #   auto-format = true;
        #   roots = [".git"];
        #   language-server = {
        #     command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-markdown-language-server";
        #   };
        # }
        # {
        #   name = "yaml";
        #   file-types = ["yaml"];
        #   auto-format = true;
        #   roots = [".git"];
        #   language-server = {
        #     command = "${pkgs.nodePackages.yaml-language-server}/bin/yaml-language-server";
        #   };
        # }
      ];
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
          auto-format = true;
          fontLigatures = true;
          lineHighlightBackground = "#ffffff0A";
          renderLineHighlightOnlyWhenFocus = true;
        };
        githubPullRequests = {
          pushBranch = "always";
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
          argumentObjectOpeningDelimeters = ["(" "[" "{"];
          argumentObjectClosingDelimeters = [")" "]" "}"];
          cursorStylePerMode = {
            insert = "line-thin";
            normal = "block";
            replace = "underline";
            visual = "block-outline";
            visualblock = "block-outline";
            visualline = "block-outline";
          };
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
          matchpairs = "(:),{:},[:],<:>";
          showMarksInGutter = true;
          smartRelativeLine = true;
          useCtrlKeys = true;
          useSystemClipboard = false;
          visualstar = true;
        };
        window.zoomLevel = 1;
        workbench.colorTheme = "Catppuccin Frappé";
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
