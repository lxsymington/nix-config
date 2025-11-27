{pkgs, ...}: {
  programs = {
    starship = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      # Seems to cause issues with `pinentry` on macOS
      # enableTransience = true;
      settings = {
        add_newline = true;
        character = {
          disabled = false;
          success_symbol = "[❯](bold green)";
          error_symbol = "[✗](bold red)";
          vimcmd_symbol = "[](bold green)";
          vimcmd_replace_one_symbol = "[](bold purple)";
          vimcmd_replace_symbol = "[](bold purple)";
          vimcmd_visual_symbol = "[](bold yellow)";
        };
        continuation_prompt = "╾─→";
        directory = {
          format = "[ $path ](bold yellow)";
          truncation_length = 3;
          truncation_symbol = "…/";

          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = "󰝚 ";
            Pictures = " ";
            Development = "󰲋 ";
          };
        };
        fill = {
          symbol = "─";
          style = "bold green";
        };
        format = ''
          [╭──$fill┨$username$shell$all┠$fill╼](bold green)
          [│](bold green)$directory$git_branch$git_commit$git_state$git_status$git_metrics
          [╰─→](bold green)$character
        '';
        git_metrics = {
          disabled = false;
          format = "[⟪ [󰐖 $added]($added_style) ❘ [󰍵 $deleted]($deleted_style) ⟫](bold white)";
        };
        os = {
          disabled = false;
          symbols = {
            Windows = "󰍲";
            Ubuntu = "󰕈";
            SUSE = "";
            Raspbian = "󰐿";
            Mint = "󰣭";
            Macos = "󰀵";
            Manjaro = "";
            Linux = "󰌽";
            Gentoo = "󰣨";
            Fedora = "󰣛";
            Alpine = "";
            Amazon = "";
            Android = "";
            Arch = "󰣇";
            Artix = "󰣇";
            CentOS = "";
            Debian = "󰣚";
            Redhat = "󱄛";
            RedHatEnterprise = "󱄛";
          };
        };
        right_format = ''
          [$status$os$line_break](bold green)
          [$time$battery$line_break](bold green)
          [$jobs$line_break](bold green)
        '';
        shell = {
          disabled = false;
          bash_indicator = "";
          fish_indicator = "󰈺";
          zsh_indicator = "󰬡";
          unknown_indicator = "";
        };
        status = {
          disabled = false;
          map_symbol = true;
          pipestatus = true;
        };
        sudo = {
          disabled = false;
        };
        time = {
          disabled = false;
          time_format = "%R";
          format = "[  $time ](bold purple)";
        };
        username = {
          show_always = true;
          format = "[ $user ](bold orange)";
        };
      };
    };
  };
}
