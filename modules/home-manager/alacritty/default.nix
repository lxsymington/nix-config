{pkgs, ...}: let
  inherit (pkgs.stdenvNoCC) isDarwin;
  fontFamily = "CommitMono Nerd Font Propo";
  theme = import ../../colours.nix;
in {
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "alacritty";
        };

        window =
          {
            dimensions = {
              columns = 240;
              lines = 80;
            };
            padding = {
              x = 20;
              y = 20;
            };
            dynamic_padding = true;
            decorations = "full";
            startup_mode = "Maximized";
            dynamic_title = true;
          }
          // pkgs.lib.optionalAttrs isDarwin {
            decorations = "Transparent";
            option_as_alt = "Both";
          };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        bell = {
          animation = "EaseOutExpo";
          duration = 300;
          color = theme {
            colour = "orange";
            subVariant = "bright";
          };
        };

        selection = {
          semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
          save_to_clipboard = true;
        };

        cursor = {
          style = {
            shape = "Block";
            blinking = "On";
          };
          vi_mode_style = "Underline";
          blink_interval = 600;
          blink_timeout = 15;
          unfocused_hollow = true;
          thickness = 0.15;
        };

        live_config_reload = true;
        working_directory = "None";

        mouse = {
          hide_when_typing = true;
          bindings = [
            {
              mouse = "Middle";
              action = "PasteSelection";
            }
          ];
        };

        font = {
          normal = {
            family = fontFamily;
            style = "Regular";
          };

          bold = {
            family = fontFamily;
            style = "Bold";
          };

          italic = {
            family = fontFamily;
            style = "Italic";
          };

          bold_italic = {
            family = fontFamily;
            style = "Bold Italic";
          };

          size =
            if isDarwin
            then 12.0
            else 10.0;

          offset = {
            x = 0;
            y =
              if isDarwin
              then 16
              else 4;
          };

          glyph_offset = {
            x = 0;
            y =
              if isDarwin
              then 8
              else 2;
          };
        };

        colors = {
          draw_bold_text_with_bright_colors = false;

          primary = {
            background = theme {colour = "black";};
            bright_foreground = theme {
              colour = "white";
              subVariant = "bright";
            };
            dim_foreground = theme {
              colour = "grey";
              subVariant = "bright";
            };
            foreground = theme {colour = "white";};
          };

          cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };

          vi_mode_cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };

          selection = {
            text = "CellBackground";
            background = "CellForeground";
          };

          search = {
            matches = {
              foreground = theme {colour = "black";};
              background = theme {
                colour = "green";
                subVariant = "bright";
              };
            };

            focused_match = {
              foreground = "CellBackground";
              background = "CellForeground";
            };
          };

          hints = {
            end = {
              background = theme {colour = "orange";};
              foreground = theme {
                colour = "white";
                subVariant = "bright";
              };
            };
            start = {
              background = theme {
                colour = "white";
                subVariant = "bright";
              };
              foreground = theme {colour = "orange";};
            };
          };

          line_indicator = {
            foreground = "None";
            background = theme {
              colour = "grey";
              subVariant = "bright";
            };
          };

          footer_bar = {
            background = theme {
              colour = "black";
              subVariant = "bright";
            };
            foreground = theme {colour = "white";};
          };

          normal = {
            black = theme {colour = "black";};
            red = theme {
              colour = "red";
              subVariant = "bright";
            };
            green = theme {
              colour = "green";
              subVariant = "bright";
            };
            yellow = theme {
              colour = "yellow";
              subVariant = "bright";
            };
            blue = theme {
              colour = "blue";
              subVariant = "bright";
            };
            magenta = theme {
              colour = "purple";
              subVariant = "bright";
            };
            cyan = theme {
              colour = "cyan";
              subVariant = "bright";
            };
            white = theme {
              colour = "white";
              subVariant = "bright";
            };
          };

          dim = {
            black = theme {
              colour = "black";
              subVariant = "dim";
            };
            red = theme {
              colour = "red";
              subVariant = "dim";
            };
            green = theme {
              colour = "green";
              subVariant = "dim";
            };
            yellow = theme {
              colour = "yellow";
              subVariant = "dim";
            };
            blue = theme {
              colour = "blue";
              subVariant = "dim";
            };
            magenta = theme {
              colour = "purple";
              subVariant = "dim";
            };
            cyan = theme {
              colour = "cyan";
              subVariant = "dim";
            };
            white = theme {
              colour = "white";
              subVariant = "dim";
            };
          };
        };
      };
    };
  };
}
