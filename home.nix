{ config, pkgs, ... }:

let
  lxs_dotfiles = builtins.fetchGit {
    url = "git@github.com:lxsymington/dotfiles.git";
    ref = "main";
    rev = "172c7800c3ec3d64a29f9b4bb17408b53ad931e1";
  };
  lxs_tmux_config = builtins.readFile (builtins.toPath "${lxs_dotfiles}/tmux/.tmux.conf");
in
{
  manual.manpages.enable = true;

  home.username = "lukexaviersymington";
  home.homeDirectory = "/Users/lukexaviersymington";
  home.stateVersion = "22.11";
  home.shellAliases = {
    "renix" = "darwin-rebuild switch --flake ~/.config/nixpkgs#";
  };

  programs.home-manager.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = lxs_tmux_config;
    aggressiveResize = true;
    baseIndex = 1;
    keyMode = "vi";
    historyLimit = 50000;
    prefix = "C-a";
    terminal = "tmux256-color";
    plugins = with pkgs.tmuxPlugins; [
      cpu
      net-speed
      open
      pain-control
      sensible
      vim-tmux-focus-events
      yank
      {
        plugin = continuum;
        extraConfig = ''
          # Enable tmux continuum
          set -g @continuum-restore 'on'
          # Set tmux continuum interval in minutes
          set -g @continuum-save-interval '5'
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          # Restore contents for panes
          set -g @resurrect-capture-pane-contents 'on'
          # Restore contents for vim
          set -g @resurrect-strategy-vim 'session'
          # Restore contents for neovim
          set -g @resurrect-strategy-nvim 'session'
          # Restore using Startify
          set -g @resurrect-processes '"nvim->nvim +SLoad"'
        '';
      }
      (mkTmuxPlugin {
       pluginName = "simple-git-status";
       version = "master";
       src = pkgs.fetchFromGitHub {
        owner = "kristijanhusak";
        repo = "tmux-simple-git-status";
        rev = "287da42f47d7204618b62f2c4f8bd60b36d5c7ed";
        sha256 = "04vs4afxcr118p78mw25nnzvlms7pmgmi2a80h92vw5pzw9a0msq";
       };
      })
    ];
  };
}
