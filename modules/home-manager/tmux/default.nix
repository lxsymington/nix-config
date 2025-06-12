{
  config,
  pkgs,
  ...
}: {
  programs = {
    tmux = {
      enable = true;
      sensibleOnTop = true;
      extraConfig = ''
        # Create a history file for Tmux
        set -g history-file ${config.xdg.configHome}/tmux/history

        # Binding for sourcing the Tmux config file
        bind-key r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display-message "Tmux configuration reloaded"

        # Enable additional terminal features
        set -as terminal-features ",*:RGB"
        set -as terminal-features ",*:strikethrough"
        set -as terminal-features ",*:usstyle"

        # Set style attributes for the Tmux status line
        set -g status-position top
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

        # Enables certain keys to be passed through to the terminal
        set -g xterm-keys on

        # Monitors
        set-option -g monitor-activity on
        set-option -g monitor-bell on
        set-option -g monitor-silence 30

        # Menu
        set-option -g menu-style 'bg=default fg=yellow dim'
        set-option -g menu-selected-style 'bg=yellow fg=default bold'
        set-option -g menu-border-lines 'single'
        set-option -g menu-border-style 'fg=grey dim'

        # Copy Mode
        set-option -g copy-mode-match-style 'bg=green fg=default dim'
        set-option -g copy-mode-current-match-style 'bg=green fg=default bold'
        set-option -g copy-mode-mark-style 'bg=grey dim'

        # Mode
        set-option -g mode-style 'bg=green fg=default dim'

        # Cursor
        set-option -g cursor-style 'blinking-block'

        # Message
        set-option -g message-command-style 'bg=default fg=magenta italics align=centre fill=default'
        set-option -g message-line 1
        set-option -g message-style 'bg=default fg=magenta dim'

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

        # Display string (by default the session name) to the left of the status line
        set-option -g status-left '#[fg=brightwhite bold]󱈤 #{session_name}#[default] '
        set-option -ag status-left '#{?session_alerts,#[fg=orange]󰂚 #{session_alerts},#[fg=green]✓}#[default] '
        set-option -g status-right '#{cpu_fg_color} #{cpu_percentage}#[default] '
        set-option -ag status-right '#{ram_fg_color} #{ram_percentage}#[default] '
        set-option -ag status-right '#[fg=magenta bold]↻ #{continuum_status}'
        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

        # Window status format and style
        set-option -g renumber-windows on
        set-option -g window-status-style 'bg=default fg=grey italics dim'
        set-option -g window-status-last-style 'fg=yellow italics dim'
        set-option -g window-status-current-style 'fg=blue us=orange bold double-underscore'
        set-option -g window-status-activity-style 'us=green dashed-underscore blink'
        set-option -g window-status-bell-style 'us=red curly-underscore blink'
        set-option -g window-status-format '#I #W'
        set-option -g window-status-current-format '#I #W'
        set-option -g window-status-separator ' ◦ '

        set -gu default-command
        set -g default-command "$SHELL"
      '';
      aggressiveResize = true;
      baseIndex = 1;
      focusEvents = true;
      keyMode = "vi";
      historyLimit = 50000;
      prefix = "C-g";
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        cpu
        open
        pain-control
        yank
        {
          plugin = tmux-sessionx;
          extraConfig = ''
            # I recommend using `o` if not already in use, for least key strokes when launching
            set -g @sessionx-bind 'o'
          '';
        }
        {
          plugin = tmux-floax;
          extraConfig = ''
            # Setting the main key to toggle the floating pane on and off
            set -g @floax-bind '-n M-f'

            # When the pane is toggled, using this bind pops a menu with additional options
            # such as resize, fullscreen, resetting to defaults and more.
            set -g @floax-bind-menu 'P'

            # The default width and height of the floating pane
            set -g @floax-width '67%'
            set -g @floax-height '67%'

            # The border color can be changed, these are the colors supported by Tmux:
            # black, red, green, yellow, blue, magenta, cyan, white for the standard
            # terminal colors; brightred, brightyellow and so on for the bright variants;
            # colour0/color0 to colour255/color255 for the colors from the 256-color
            # palette; default for the default color; or a hexadecimal RGB color such as #882244.
            set -g @floax-border-color 'magenta'

            # The text color can also be changed, by default it's blue
            # to distinguish from the main window
            # Optional colors are as shown above in @floax-border-color
            set -g @floax-text-color 'blue'

            # By default when floax sees a change in session path
            # it'll change the floating pane's path
            # You can disable this by setting it to false
            # You could also "cd -" when the pane is toggled to go back
            set -g @floax-change-path 'true'

            # The default session name of the floating pane is 'scratch'
            # You can modify the session name with this option:
            set -g @floax-session-name 'some-other-session-name'

            # Change the title of the floating window
            set -g @floax-title 'floax'
          '';
        }
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-processes '"nvim->nvim +SLoad"'
          '';
        }
      ];
    };
  };
}
