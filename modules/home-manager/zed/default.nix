{lib, ...}: {
  programs = {
    zed-editor = {
      enable = true;

      extensions = [
        "vitesse-theme-refined"
      ];

      userKeymaps = [
        {
          context = "Editor";
          bindings = {
            "ctrl-k" = "editor::AcceptEditPrediction";
          };
        }
        {
          context = "Editor && showing_completions";
          bindings = {
            "ctrl-y" = "editor::ConfirmCompletion";
          };
        }
        {
          context = "Editor && showing_code_actions";
          bindings = {
            "ctrl-y" = "editor::ConfirmCodeAction";
          };
        }
        {
          context = "Editor && vim_mode == insert";
          bindings = {
            "j j" = ["workspace::SendKeystrokes" "escape"];
          };
        }
      ];

      userSettings = {
        icon_theme = "Zed (Default)";
        features = {
          edit_prediction_provider = "zed";
        };
        active_pane_modifiers = {
          border_size = 2.0;
          inactive_opacity = 0.5;
        };
        agent = {
          always_allow_tool_actions = true;
          play_sound_when_agent_done = true;
          default_model = {
            provider = "zed.dev";
            model = "claude-sonnet-4-thinking";
          };
          version = "2";
        };
        buffer_font_family = "CommitMono Nerd Font Propo";
        buffer_line_height = {
          custom = 2.0;
        };
        buffer_font_size = lib.mkForce 12;
        centered_layout = {
          enabled = true;
          left_padding = 0.2;
          right_padding = 0.2;
        };
        code_actions_on_format = {
          "source.fixAll.biome" = true;
          "source.organizeImports.biome" = true;
        };
        diagnostics = {
          enabled = true;
        };
        enable_language_server = true;
        format_on_save = "on";
        formatter = {
          language_server = {
            name = "biome";
          };
        };
        inlay_hints = {
          enabled = true;
          show_type_hints = true;
          show_parameter_hints = true;
          show_other_hints = true;
          show_background = false;
          edit_debounce_ms = 700;
          scroll_debounce_ms = 50;
          toggle_on_modifiers_press = null;
        };
        node = {
          npm_path = "npm";
          package_manager = "npm";
          runtime_path = "node";
        };
        lsp = {
          biome = {
            settings = {
              require_config_file = true;
            };
          };
          vtsls = {
            settings = {
              typescript = {tsserver = {maxTsServerMemory = 16184;};};
              javascript = {tsserver = {maxTsServerMemory = 16184;};};
            };
          };
        };
        tabs = {
          close_position = "left";
          file_icons = true;
          git_status = true;
          activate_on_close = "history";
          show_close_button = "always";
          show_diagnostics = "errors";
        };
        terminal = {
          font_family = "CommitMono Nerd Font Propo";
          font_size = 12;
          line_height = {
            custom = 2.0;
          };
        };
        unnecessary_code_fade = 0.5;
        theme = lib.mkForce {
          mode = "system";
          light = "One Light";
          dark = "Kanagawa Wave";
        };
        ui_font_family = lib.mkForce "CommitMono Nerd Font Propo";
        ui_font_size = lib.mkForce 12;
        vim_mode = true;
      };
    };
  };
}
