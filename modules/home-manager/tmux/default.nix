{ self, inputs, config, pkgs, ... }:

let
  lxs_tmux_darwin_config = builtins.toPath ./tmux.macos.conf;
  lxs_tmux_linux_config = builtins.toPath ./tmux.linux.conf;
in
{
  programs = {
    tmux = {
      enable = true;
      extraConfig = ''
        # Create a history file for Tmux
        set -g history-file ~/.config/tmux/history

        # Binding for sourcing the Tmux config file
        bind-key r source-file ${pkgs.tmux}/tmux.conf \; display-message "Tmux configuration reloaded"

        # Enable additional terminal features
        set -as terminal-features ",*:RGB"
        set -as terminal-features ",*:strikethrough"
        set -as terminal-features ",*:usstyle"

        # Set the foreground and background colours for the Tmux status line
        set -g status-style 'bg=default'
        set -g status-style 'fg=default'

        # Use vi keybindings in the status line, for example at the command prompt
        set -g status-keys 'vi'

        # Use vi keybindings in copy mode
        setw -g mode-keys 'vi'

        # Set the position of the window list component of the status line: left, centre or right justified.
        set -g status-justify 'centre'
        
        # Let the status length be up to 80 characters in length
        set -g status-left-length 120
        
        # Let the status length be up to 80 characters in length
        set -g status-right-length 120
        
        # Pane decorations
        set -g pane-active-border-style 'fg=brightmagenta,bold'
        set -g pane-border-style 'fg=white,dim,italics'
        set -g pane-border-status 'top' 
        
        # window rename
        set -g status-interval 5
        set -g automatic-rename on
        set -g automatic-rename-format '#{b:pane_current_path}'
        
        # Enable the Mouse
        set -g mouse on

        # Enable focus events in Tmux
        set -g focus-events on

        # make dbus available in tmux
        set -g update-environment 'DBUS_SESSION_BUS_ADDRESS'
        
        # Make new Tmux windows open at the current working directory
        bind c new-window -c '#{pane_current_path}'

        # Set a binding for opening a fuzzy search for switchable Tmux sessions
        bind-key C-j split-window -v "tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse | xargs tmux switch-client -t"
        
        # Prompted join pane
        bind-key J command-prompt -p "Join pane from: " "join-pane -h -s '%%'"
        
        # Easily swap a pane (targeted by pane number) with the current pane
        bind-key S select-pane -m\; choose-tree -Zw "swap-pane -t '%%'"
        
        # Open a fixed size split
        bind-key Tab split-window -h -l 80 -c '#{pane_current_path}'

        # Import platform specific config
        if-shell "uname | grep -q Darwin" "source-file ${lxs_tmux_darwin_config}" "source-file ${lxs_tmux_linux_config}"
      '';
      aggressiveResize = true;
      baseIndex = 1;
      keyMode = "vi";
      historyLimit = 50000;
      prefix = "C-a";
      terminal = "tmux-256color";
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
  };
}
