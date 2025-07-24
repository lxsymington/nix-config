{pkgs, ...}: {
  programs = {
    zed-editor = {
      enable = true;

      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            "shift shift" = "file_finder::Toggle";
          };
        }
        {
          context = "Editor";
          bindings = {
            ctrl-y = "editor::AcceptEditPrediction";
          };
        }
        {
          context = "Editor && showing_completions";
          bindings = {
            ctrl-y = "editor::ConfirmCompletion";
          };
        }
        {
          context = "Editor && showing_code_actions";
          bindings = {
            ctrl-y = "editor::ConfirmCodeAction";
          };
        }
        {
          context = "Editor && vim_mode == insert";
          bindings = {
            "j k" = ["workspace::SendKeystrokes" "escape"];
          };
        }
        {
          context = "vim_mode == insert && !(showing_code_actions || showing_completions)";
          bindings = {
            ctrl-y = "editor::AcceptEditPrediction";
          };
        }
      ];

      userSettings = {
        icon_theme = "Zed (Default)";
        context_servers = {
          mcp-server-github = {
            source = "extension";
            settings = {
              github_personal_access_token = "GITHUB_PERSONAL_ACCESS_TOKEN";
            };
          };
        };
        features = {
          edit_prediction_provider = "zed";
        };
        active_pane_modifiers = {
          border_size = 0.0;
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
        buffer_font_size = 12;
        centered_layout = {
          enabled = true;
          left_padding = 0.2;
          right_padding = 0.2;
        };
        code_actions_on_format = {
          source.fixAll.biome = true;
          source.organizeImports.biome = true;
        };
        copilot = {
          enabled = true;
        };
        diagnostics = {
          enabled = true;
        };
        edit_predictions = {
          enabled = true;
          mode = "subtle";
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
        show_copilot_suggestions = true;
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
        theme = {
          mode = "system";
          light = "One Light";
          dark = "Kanagawa Wave";
        };
        ui_font_family = "CommitMono Nerd Font Propo";
        ui_font_size = 12;
        unnecessary_code_fade = 0.5;
        vim_mode = true;
      };
    };
  };
}
/*
   {
  "icon_theme": "Zed (Default)",
  "features": {
    "edit_prediction_provider": "zed"
  },
  "active_pane_modifiers": {
    "border_size": 2.0,
    "inactive_opacity": 0.5
  },
  "agent": {
    "default_profile": "ask",
    "always_allow_tool_actions": true,
    "play_sound_when_agent_done": true,
    "default_model": {
      "provider": "zed.dev",
      "model": "claude-sonnet-4-thinking"
    },
    "version": "2"
  },
  "buffer_font_family": "CommitMono Nerd Font Propo",
  "buffer_line_height": {
    "custom": 2.0
  },
  "buffer_font_size": 12,
  "centered_layout": {
    "enabled": true,
    "left_padding": 0.2,
    "right_padding": 0.2
  },
  "code_actions_on_format": {
    "source.fixAll.biome": true,
    "source.organizeImports.biome": true
  },
  "copilot": {
    "enabled": true
  },
  "diagnostics": {
    "enabled": true
  },
  "edit_predictions": {
    "enabled": true,
    "mode": "eager"
  },
  "enable_language_server": true,
  "format_on_save": "on",
  "formatter": {
    "language_server": {
      "name": "biome"
    }
  },
  "inlay_hints": {
    "enabled": true,
    "show_type_hints": true,
    "show_parameter_hints": true,
    "show_other_hints": true,
    "show_background": false,
    "edit_debounce_ms": 700,
    "scroll_debounce_ms": 50,
    "toggle_on_modifiers_press": null
  },
  "node": {
    "npm_path": "npm",
    "package_manager": "npm",
    "runtime_path": "node"
  },
  "lsp": {
    "biome": {
      "settings": {
        "require_config_file": true
      }
    },
    "vtsls": {
      "settings": {
        // For TypeScript:
        "typescript": { "tsserver": { "maxTsServerMemory": 16184 } },
        // For JavaScript:
        "javascript": { "tsserver": { "maxTsServerMemory": 16184 } }
      }
    }
  },
  "show_copilot_suggestions": true,
  "tabs": {
    "close_position": "left",
    "file_icons": true,
    "git_status": true,
    "activate_on_close": "history",
    "show_close_button": "always",
    "show_diagnostics": "errors"
  },
  "terminal": {
    "font_family": "CommitMono Nerd Font Propo",
    "font_size": 12,
    "line_height": {
      "custom": 2.0
    }
  },
  "theme": {
    "mode": "system",
    "light": "Vitesse Refined Light",
    "dark": "Kanagawa Wave"
  },
  "ui_font_family": "CommitMono Nerd Font Propo",
  "ui_font_size": 12,
  "unnecessary_code_fade": 0.5,
  "vim_mode": true
}
*/
/*
   [
  {
    "context": "Workspace",
    "bindings": {
      // "shift shift": "file_finder::Toggle"
    }
  },
  {
    "context": "Editor",
    "bindings": {
      "ctrl-k": "editor::AcceptEditPrediction"
    }
  },
  {
    "context": "Editor && showing_completions",
    "bindings": {
      "ctrl-y": "editor::ConfirmCompletion"
    }
  },
  {
    "context": "Editor && showing_code_actions",
    "bindings": {
      "ctrl-y": "editor::ConfirmCodeAction"
    }
  },
  {
    "context": "Editor && vim_mode == insert",
    "bindings": {
      "j k": ["workspace::SendKeystrokes", "escape"]
    }
  }
]
*/

