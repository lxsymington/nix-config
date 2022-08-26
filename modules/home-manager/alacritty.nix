{ dotfiles, config, pkgs, ... }:

{
  enable = true;
  settings = {
    env = {
      TERM = "alacritty";
    };

    window = {
      dimensions = {
        columns = 240;
	rows = 80;
      };
      padding = {
        x = 20;
	y = 20;
      };
      dynamic_padding = true;
      decorations = "full";
      startup_mode = "Maximised";
      dynamic_title = true;
    };

    scrolling = {
      history = 10000;
      multiplier = 3;
    };

    bell = {
      animation = "EaseOutExpo";
      duration = 300;
      color = "#a3293d";
    }

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

    alt_send_esc = false;

    mouse = {
      hide_when_typing = true;
    };

    hints = {
      alphabet = "jfkdls;ahgurieowpq";
      enabled: [
        {
          regex: "(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>\"\\s{-}\\^⟨⟩`]+";
          command = "xdg-open";
          post_processing = true;
          mouse = {
            enabled = true;
            mods = "None";
	  };
          binding = {
            key = "U";
            mods = "Control|Shift";
	  };
	};
      ];
    };

    mouse_bindings = [
      {
        mouse = "Middle";
	action = "PasteSelection";
      };
    ];
  };
}
