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
        git = {
          inline_blame = {
            show_commit_summary = true;
          };
        };
        debugger = {
          stepping_granularity = "statement";
        };
        git_panel = {
          sort_by_path = true;
        };
        bottom_dock_layout = "full";
        preview_tabs = {
          enable_preview_from_code_navigation = true;
          enable_preview_from_file_finder = true;
        };
        title_bar = {
          show_menus = true;
          show_branch_icon = true;
        };
        languages = {
          TypeScript = {
            preferred_line_length = 100;
            soft_wrap = "preferred_line_length";
          };
        };
        diagnostics = {
          inline = {
            enabled = true;
          };
        };
        completions = {
          lsp_insert_mode = "replace_subsequence";
        };
        show_edit_predictions = true;
        indent_guides = {
          coloring = "indent_aware";
          background_coloring = "disabled";
        };
        toolbar = {
          code_actions = true;
        };
        minimap = {
          show = "never";
        };
        relative_line_numbers = true;
        show_signature_help_after_edits = true;
        auto_signature_help = true;
        icon_theme = {
          mode = "system";
          light = "Colored Zed Icons Theme Light";
          dark = "Colored Zed Icons Theme Dark";
        };
        features = {
          edit_prediction_provider = "zed";
        };
        active_pane_modifiers = {
          border_size = 2.0;
          inactive_opacity = 0.5;
        };
        agent = {
          default_profile = "ask";
          always_allow_tool_actions = true;
          play_sound_when_agent_done = true;
          default_model = {
            provider = "zed.dev";
            model = "claude-sonnet-4-thinking";
          };
        };
        buffer_font_family = "CommitMono Nerd Font Propo";
        buffer_line_height = {
          custom = 2.0;
        };
        buffer_font_size = lib.mkForce 12;
        centered_layout = {
          left_padding = 0.2;
          right_padding = 0.2;
        };
        code_actions_on_format = {
          source.fixAll.biome = true;
          source.organizeImports.biome = true;
        };
        edit_predictions = {
          mode = "eager";
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
          show_background = true;
          edit_debounce_ms = 700;
          scroll_debounce_ms = 50;
          toggle_on_modifiers_press = null;
        };
        node = {
          npm_path = "npm";
        };
        lsp = {
          biome = {
            settings = {
              require_config_file = true;
            };
          };
          vtsls = {
            settings = {
              typescript = {
                tsserver = {
                  maxTsServerMemory = 16184;
                };
              };
              javascript = {
                tsserver = {
                  maxTsServerMemory = 16184;
                };
              };
            };
          };
        };
        tabs = {
          close_position = "left";
          file_icons = true;
          git_status = true;
          activate_on_close = "history";
          show_close_button = "always";
          show_diagnostics = "all";
        };
        terminal = {
          toolbar = {
            breadcrumbs = true;
          };
          option_as_meta = true;
          font_family = "CommitMono Nerd Font Propo";
          font_size = 12;
          line_height = {
            custom = 2.0;
          };
        };
        theme = lib.mkForce {
          mode = "system";
          light = "Vitesse Refined Light";
          dark = "Vitesse Refined Dark";
        };
        ui_font_family = lib.mkForce "CommitMono Nerd Font Propo";
        ui_font_size = lib.mkForce 12;
        unnecessary_code_fade = 0.5;
        vim_mode = true;
        auto_install_extensions = {
          vitesse-theme-refined = true;
        };
      };
    };
  };
}
