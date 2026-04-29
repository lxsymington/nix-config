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
        active_pane_modifiers = {
          border_size = 2.0;
          inactive_opacity = 0.5;
        };
        agent = {
          always_allow_tool_actions = true;
          default_model = {
            provider = "copilot_chat";
            model = "claude-sonnet-4.6";
          };
          default_profile = "ask";
          favorite_models = [
            {
              provider = "copilot_chat";
              model = "claude-opus-4.6";
            }
            {
              provider = "copilot_chat";
              model = "claude-haiku-4.5";
            }
          ];
          inline_assistant_model = {
            provider = "copilot_chat";
            model = "claude-sonnet-4.6";
          };
          notify_when_agent_waiting = "all_screens";
          play_sound_when_agent_done = true;
          tool_permissions = {default = "allow";};
          use_modifier_to_send = true;
        };
        agent_servers = {
          opencode = {
            default_config_options = {"mode" = "Architect";};
            favorite_config_option_values = {
              model = [
                "github-copilot/gpt-5.4"
                "github-copilot/gpt-5.3-codex"
                "github-copilot/gemini-3-flash-preview"
                "github-copilot/claude-opus-4.6"
                "github-copilot/claude-haiku-4.5"
                "github-copilot/claude-sonnet-4.6"
                "github-copilot/gemini-3.1-pro-preview"
              ];
            };
            type = "registry";
          };
          github-copilot-cli = {
            favorite_config_option_values = {
              model = [
                "claude-opus-4.6"
                "claude-sonnet-4.6"
                "claude-haiku-4.5"
                "gemini-3-pro-preview"
              ];
            };
            type = "registry";
          };
          github-copilot = {
            favorite_models = [
              "claude-opus-4.6"
            ];
            default_model = "claude-opus-4.5";
            type = "registry";
          };
        };
        agent_ui_font_size = lib.mkForce 12.0;
        auto_install_extensions = {
          colored-zed-icons-theme = true;
          opencode = true;
          shhhed-theme = true;
          vitesse-theme-refined = true;
        };
        auto_signature_help = true;
        base_keymap = "VSCode";
        bottom_dock_layout = "full";
        buffer_font_family = "CommitMono Nerd Font Propo";
        buffer_font_size = lib.mkForce 12.0;
        buffer_line_height = {custom = 2.0;};
        centered_layout = {
          left_padding = 0.2;
          right_padding = 0.2;
        };
        close_on_file_delete = true;
        code_actions_on_format = {
          "source.fixAll.biome" = true;
          "source.organizeImports.biome" = true;
        };
        colorize_brackets = true;
        completions = {lsp_insert_mode = "replace_subsequence";};
        context_servers = {
          Atlassian-Rovo-MCP = {
            env = {};
            command = "npx";
            args = [
              "-y"
              "mcp-remote@latest"
              "https =//mcp.atlassian.com/v1/mcp"
            ];
          };
        };
        debugger = {stepping_granularity = "statement";};
        diagnostics = {inline = {enabled = true;};};
        edit_predictions = {
          provider = "copilot";
          mode = "eager";
        };
        enable_language_server = true;
        excerpt_context_lines = 3;
        file_finder = {modal_max_width = "medium";};
        format_on_save = "on";
        formatter = {language_server = {name = "biome";};};
        git = {inline_blame = {show_commit_summary = true;};};
        git_panel = {
          tree_view = true;
          sort_by_path = true;
        };
        icon_theme = {
          mode = "system";
          light = "Colored Zed Icons Theme Light";
          dark = "Colored Zed Icons Theme Dark";
        };
        indent_guides = {
          coloring = "indent_aware";
          background_coloring = "disabled";
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
        lsp = {
          biome = {settings = {require_config_file = true;};};
          vtsls = {
            settings = {
              typescript = {
                tsserver = {
                  maxTsServerMemory = 16184;
                };
                updateImportsOnFileMove = {
                  enabled = "always";
                };
              };
              javascript = {
                tsserver = {
                  maxTsServerMemory = 16184;
                };
                updateImportsOnFileMove = {
                  enabled = "always";
                };
              };
            };
          };
        };
        minimap = {show = "never";};
        node = {npm_path = "npm";};
        preview_tabs = {
          enable_keep_preview_from_code_navigation = true;
          enable_preview_from_file_finder = true;
          enable_preview_multibuffer_from_code_navigation = true;
        };
        relative_line_numbers = true;
        search = {
          center_on_match = true;
          regex = true;
        };
        show_edit_predictions = true;
        show_signature_help_after_edits = true;
        snippet_sort_order = "top";
        soft_wrap = "editor_width";
        sticky_scroll = {enabled = true;};
        tabs = {
          close_position = "left";
          file_icons = true;
          git_status = true;
          activate_on_close = "history";
          show_close_button = "always";
          show_diagnostics = "all";
        };
        terminal = {
          dock = "bottom";
          font_family = "CommitMono Nerd Font Propo";
          font_size = 12;
          line_height = {custom = 2.0;};
          option_as_meta = true;
          toolbar = {breadcrumbs = true;};
        };
        theme = lib.mkForce {
          mode = "system";
          light = "shhhed light";
          dark = "shhhed";
        };
        title_bar = {
          show_menus = true;
          show_branch_icon = true;
        };
        toolbar = {code_actions = true;};
        ui_font_family = lib.mkForce "CommitMono Nerd Font Propo";
        ui_font_size = lib.mkForce 12;
        unnecessary_code_fade = 0.5;
        vim = {
          toggle_relative_line_numbers = false;
        };
        vim_mode = true;
        which_key = {
          delay_ms = 200;
          enabled = true;
        };
      };
    };
  };
}
