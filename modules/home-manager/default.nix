{ self, inputs, config, pkgs, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "git@github.com:lxsymington/dotfiles.git";
    ref = "main";
    rev = "327698d20d33ecd7f5848004a5585b95027c409e";
  };
  assume-role = builtins.fetchGit {
    url = "git@github.com:ibisnetworks/assume-role.git";
    ref = "master";
    rev =  "b59b398b6c197eb2442a13cf8afe08936501b881";
  };
  build_alacritty_config = import ./alacritty.nix;
  build_fish_config = import ./fish.nix;
  build_git_config = import ./git.nix;
  build_tmux_config = import ./tmux.nix;
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
      emscripten
      fd
      figlet
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
      pandoc
      pcre
      pinentry
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
    tmux = build_tmux_config { inherit dotfiles config pkgs; };
    vscode = {
      enable = true;
      userSettings = {
        "editor.cursorSurroundingLines" = 5;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.lineHighlightBackground" = "#ffffff0A";
        "editor.renderLineHighlight" = "none";
        "editor.renderLineHighlightOnlyWhenFocus" = true;
        "githubPullRequests.pushBranch" = "always";
        "liveshare.allowGuestDebugControl" = true;
        "liveshare.allowGuestTaskControl" = true;
        "liveshare.guestApprovalRequired" = true;
        "liveshare.joinDebugSessionOption" = "Prompt";
        "liveshare.languages.allowGuestCommandControl" = true;
        "liveshare.launcherClient" = "visualStudioCode";
        "liveshare.presence" = true;
        "mochaExplorer.exit" = true;
        "mochaExplorer.parallel" = true;
        "mochaExplorer.pruneFiles" = true;
        "mochaExplorer.timeout" = 3000;
        "terminal.explorerKind" = "external";
        "terminal.external.osxExec" = "Alacritty.app";
        "terminal.integrated.localEchoStyle" = "dim";
        "testExplorer.addToEditorContextMenu" = true;
        "testExplorer.mergeSuites" = true;
        "testExplorer.onReload" = "retire";
        "testExplorer.onStart" = "retire";
        "testExplorer.showOnRun" = true;
        "testExplorer.sort" = "byLocationWithSuitesFirst";
        "testExplorer.useNativeTesting" = true;
        "typescript.tsdk" = "./node_modules/typescript/lib";
        "vim.argumentObjectClosingDelimiters" = [")" "]" "}"];
        "vim.argumentObjectOpeningDelimiters" = ["(" "[" "{"];
        "vim.cursorStylePerMode.insert" = "line-thin";
        "vim.cursorStylePerMode.normal" = "block";
        "vim.cursorStylePerMode.replace" = "underline";
        "vim.cursorStylePerMode.visual" = "block-outline";
        "vim.cursorStylePerMode.visualblock" = "block-outline";
        "vim.cursorStylePerMode.visualline" = "block-outline";
        "vim.highlightedyank.enable" = true;
        "vim.hlsearch" = true;
        "vim.incsearch" = true;
        "vim.insertModeKeyBindings" = [
          {
            before = ["j" "j"];
            after = ["<Esc>"];
          }
        ];
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            before = ["K"];
            commands = [
              "editor.action.showHover"
            ]; 
          }
          {
            before = ["leader" "@" "d"];
            commands = [
              "editor.action.showDefinitionPreviewHover"
            ]; 
          }
          {
            before = ["leader" "t" "n"];
            commands = [
              "testing.runAtCursor"
            ]; 
          }
          {
            before = ["leader" "t" "f"];
            commands = [
              "testing.runCurrentFile"
            ]; 
          }
          {
            before = ["leader" "t" "d"];
            commands = [
              "testing.debugAtCursor"
            ]; 
          }
          {
            before = ["]" "d"];
            commands = [
              "editor.action.marker.next"
            ];
          }
          {
            before = ["[" "d"];
            commands = [
              "editor.action.marker.prev"
            ];
          }
          {
            before = ["]" "c"];
            commands = [
              "workbench.action.editor.nextChange"
            ];
          }
          {
            before = ["[" "c"];
            commands = [
              "workbench.action.editor.previousChange"
            ];
          }
          {
            before = ["]" "t"];
            commands = [
              "testing.goToNextMessage"
            ];
          }
          {
            before = ["[" "t"];
            commands = [
              "testing.goToPreviousMessage"
            ];
          }
        ];
        "vim.leader" = "<space>";
        "vim.matchpairs" = "(:),{:},[:],<:>";
        "vim.showMarksInGutter" = true;
        "vim.smartRelativeLine" = true;
        "vim.useCtrlKeys" = true;
        "vim.useSystemClipboard" = false;
        "vim.visualstar" = true;
        "window.autoDetectColorScheme" = true;
        "window.zoomLevel" = 1;
        "workbench.colorTheme" = "Catppuccin Latte";
        "workbench.preferredDarkColorTheme" = "Catppuccin Frappé";
        "workbench.preferredLightColorTheme" = "Catppuccin Latte";
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
