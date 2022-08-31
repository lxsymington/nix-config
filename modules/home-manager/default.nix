{ config, pkgs, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "git@github.com:lxsymington/dotfiles.git";
    ref = "main";
    rev = "327698d20d33ecd7f5848004a5585b95027c409e";
  };
  lxs_neovim_config = builtins.readFile (builtins.toPath "${dotfiles}/nvim/init.lua");
  build_alacritty_config = import ./alacritty.nix;
  build_fish_config = import ./fish.nix;
  build_git_config = import ./git.nix;
  build_tmux_config = import ./tmux.nix;
in
{
  manual.manpages.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  home = {
    packages = with pkgs; [
      ansible
      aws-sam-cli
      awscli
      cachix
      cargo
      delta
      # deno
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
      luajit
      luajitPackages.luarocks
      mongodb-tools
      mongosh
      multimarkdown
      nghttp2
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
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;
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
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    tealdeer.enable = true;
    tmux = build_tmux_config { inherit dotfiles config pkgs; };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
