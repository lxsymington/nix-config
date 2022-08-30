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
      awscli
      aws-sam-cli
      cachix
      delta
      docker
      fd
      figlet
      gojq
      imagemagick
      inetutils
      llvm
      mongodb-tools
      mongosh
      multimarkdown
      pandoc
      pinentry
      pinentry_mac
      pritunl-ssh
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

  programs = {
    home-manager.enable = true;
    alacritty = build_alacritty_config { inherit dotfiles config pkgs; };
    bat = {
      enable = true;
      config = {
        theme = "Solarized (light)";
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
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
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
