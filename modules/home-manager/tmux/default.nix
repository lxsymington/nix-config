{
  config,
  pkgs,
  ...
}: {
  programs = {
    tmux = {
      enable = true;
      extraConfig = ''
        # Create a history file for Tmux
        set -g history-file ${config.xdg.configHome}/tmux/history

        # Binding for sourcing the Tmux config file
        bind-key r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display-message "Tmux configuration reloaded"

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

        # Configure the battery plugin
        set-option -g @batt_icon_charge_tier8 '󰁹'
        set-option -g @batt_icon_charge_tier7 '󰂁'
        set-option -g @batt_icon_charge_tier6 '󰁿'
        set-option -g @batt_icon_charge_tier5 '󰁾'
        set-option -g @batt_icon_charge_tier4 '󰁼'
        set-option -g @batt_icon_charge_tier3 '󰁻'
        set-option -g @batt_icon_charge_tier2 '󰁺'
        set-option -g @batt_icon_charge_tier1 '󱟩'
        set-option -g @batt_icon_status_charged ''
        set-option -g @batt_icon_status_charging '⚡'
        set-option -g @batt_icon_status_discharging '󱟞'

        # Display string (by default the session name) to the left of the status line
        set-option -g status-left '#[fg=brightwhite bold]󱈤 #{session_name}#[default] '
        set-option -ag status-left '#{?session_alerts,#[fg=orange]󰂚 #{session_alerts},#[fg=green]✓}#[default] '
        set-option -ag status-left '#{cpu_fg_color} #{cpu_percentage}#[default] '
        set-option -ag status-left '#{ram_fg_color} #{ram_percentage}#[default] '
        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

        # Display string (by default the session name) to the right of the status line
        set-option -g status-right '#[fg=white dim]⬇️ #{download_speed} ⬆️ #{upload_speed}#[default] '
        set-option -ag status-right '#[fg=brightyellow italics]%A %d %B %G#[default] '
        set-option -ag status-right '#[fg=brightwhite bold]%R %Z#[default] '
        set-option -ag status-right '#{battery_icon} #{battery_percentage} #{battery_remain} '
        run-shell ${pkgs.tmuxPlugins.net-speed}/share/tmux-plugins/net-speed/net_speed.tmux
        run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux

        # Window status format and style
        set-option -g window-status-activity-style 'fg=brightwhite bold underscore blink'
        set-option -g window-status-format '#[fg=yellow italics dim] #I #W #[default]'
        set-option -g window-status-current-format '#[fg=magenta] #I #W #[default]'
        set-option -g window-status-separator '⁞'

        # Enable tmux continuum
        set -g @continuum-restore 'on'
        # Set tmux continuum interval in minutes
        set -g @continuum-save-interval '5'
        run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux

        # Restore contents for panes
        set -g @resurrect-capture-pane-contents 'on'
        # Restore contents for vim
        set -g @resurrect-strategy-vim 'session'
        # Restore contents for neovim
        set -g @resurrect-strategy-nvim 'session'
        # Restore using Startify
        set -g @resurrect-processes '"nvim->nvim +SLoad"'
        run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
      '';
      aggressiveResize = true;
      baseIndex = 1;
      keyMode = "vi";
      historyLimit = 50000;
      prefix = "C-a";
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        battery
        cpu
        net-speed
        open
        pain-control
        sensible
        yank
        continuum
        resurrect
      ];
    };
  };
}
