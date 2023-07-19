{ pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.isDarwin;
  fontFamily = if isDarwin then "JetBrainsMono Nerd Font" else "JetBrainsMonoNL Nerd Font";
in {
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
          decorations = if isDarwin then "transparent" else "full";
          startup_mode = "Maximized";
          dynamic_title = true;
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
          unfocussed_hollow = true;
          thickness = 0.15;
        };

        live_config_reload = true;
        working_directory = "None";

        mouse = {
          hide_when_typing = true;
        };

        mouse_bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
          
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

          size = 12.0;

          offset = {
            x = 0;
            y = 8;
          };

          glyph_offset = {
            x = 0;
            y = 4;
          };
        };
      };
    };
  };
}
