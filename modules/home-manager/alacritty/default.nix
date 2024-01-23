{ pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.isDarwin;
  fontFamily = "CommitMono Nerd Font Propo";
  theme = import ../../colours.nix;
in
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "alacritty";
        };

        window = {
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
        } // pkgs.lib.optionalAttrs (isDarwin) {
          decorations = "transparent";
          option_as_alt = "Both";
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        bell = {
          animation = "EaseOutExpo";
          duration = 300;
          color = "#a3293d";
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
            style = "Extra Bold";
          };

          italic = {
            family = fontFamily;
            style = "Italic";
          };

          bold_italic = {
            family = fontFamily;
            style = "Extra Bold Italic";
          };

          size = if isDarwin then 12.0 else 10.0;

          offset = {
            x = 0;
            y = if isDarwin then 8 else 4;
          };

          glyph_offset = {
            x = 0;
            y = if isDarwin then 4 else 2;
          };
        };

        colors = {
          draw_bold_text_with_bright_colors = false;

          primary = {
            background = theme { colour = "black"; };
            bright_foreground = theme { colour = "white"; variant = "light"; };
            dim_foreground = theme { colour = "grey"; variant = "light"; };
            foreground = theme { colour = "white"; };
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
              foreground = theme { colour = "black"; };
              background = theme { colour = "green"; variant = "light"; };
            };

            focused_match = {
              foreground = "CellBackground";
              background = "CellForeground";
            };
          };

          hints = {
            end = {
              background = theme { colour = "orange"; };
              foreground = theme { colour = "white"; variant = "light"; };
            };
            start = {
              background = theme { colour = "white"; variant = "light"; };
              foreground = theme { colour = "orange"; };
            };
          };

          line_indicator = {
            foreground = "None";
            background = theme { colour = "grey"; variant = "light"; };
          };

          footer_bar = {
            background = theme { colour = "black"; variant = "light"; };
            foreground = theme { colour = "white"; };
          };

          normal = {
            black = theme { colour = "black"; };
            red = theme { colour = "red"; variant = "light"; };
            green = theme { colour = "green"; variant = "light"; };
            yellow = theme { colour = "yellow"; variant = "light"; };
            blue = theme { colour = "blue"; variant = "light"; };
            magenta = theme { colour = "purple"; variant = "light"; };
            cyan = theme { colour = "cyan"; variant = "light"; };
            white = theme { colour = "white"; variant = "light"; };
          };

          dim = {
            black = theme { colour = "black"; variant = "dim"; };
            red = theme { colour = "red"; variant = "dim"; };
            green = theme { colour = "green"; variant = "dim"; };
            yellow = theme { colour = "yellow"; variant = "dim"; };
            blue = theme { colour = "blue"; variant = "dim"; };
            magenta = theme { colour = "purple"; variant = "dim"; };
            cyan = theme { colour = "cyan"; variant = "dim"; };
            white = theme { colour = "white"; variant = "dim"; };
          };
        };
      };
    };
  };
}
