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

        # Enables certain keys to be passed through to the terminal
        set -g xterm-keys on

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
      '';
      aggressiveResize = true;
      baseIndex = 1;
      focusEvents = true;
      keyMode = "vi";
      historyLimit = 50000;
      prefix = "C-g";
      shell = "${pkgs.fish}/bin/fish";
      sensibleOnTop = true;
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        battery
        cpu
        net-speed
        open
        pain-control
        sensible
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
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-boot-options 'alacritty'
            set -g @continuum-save-interval '5'
          '';
        }
      ];
    };
  };
}
