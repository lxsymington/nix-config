{ config
, ...
}:
let
  theme = import ../../colours.nix;
in
{
  xdg = {
    configFile = {
      ghostty = {
        enable = true;
        source = ./ghostty.config;
        target = "${config.xdg.configHome}/ghostty/config";
      };

      ghostty_crepuscular_dusk = {
        enable = true;
        text = ''
          palette = 0=${ theme { colour = "black"; } }
          palette = 1=${ theme { colour = "blue"; subVariant = "dim"; } }
          palette = 2=${ theme { colour = "purple"; subVariant = "bright"; } }
          palette = 3=${ theme { colour = "grey"; } }
          palette = 4=${ theme { colour = "cyan"; subVariant = "dim"; } }
          palette = 5=${ theme { colour = "white"; } }
          palette = 6=${ theme { colour = "yellow"; subVariant = "dim"; } }
          palette = 7=${ theme { colour = "purple"; subVariant = "dim"; } }
          palette = 8=${ theme { colour = "red"; subVariant = "bright"; } }
          palette = 9=${ theme { colour = "orange"; subVariant = "bright"; } }
          palette = 10=${ theme { colour = "yellow"; } }
          palette = 11=${ theme { colour = "green"; subVariant = "bright"; } }
          palette = 12=${ theme { colour = "cyan"; } }
          palette = 13=${ theme { colour = "blue"; subVariant = "bright"; } }
          palette = 14=${ theme { colour = "purple"; } }
          palette = 15=${ theme { colour = "orange"; subVariant = "dim"; } }
          background = ${ theme { colour = "black"; subVariant = "dim"; } }
          foreground = ${ theme { colour = "white"; subVariant = "dim"; } }
          cursor-color = ${ theme { colour = "yellow"; subVariant = "dim"; } }
          selection-background = ${ theme { colour = "green"; subVariant = "dim"; } }
          selection-foreground = ${ theme { colour = "black"; subVariant = "bright"; } }
        '';
        target = "${config.xdg.configHome}/ghostty/themes/crepuscular-dusk";
      };

      ghostty_crepuscular_dawn = {
        enable = true;
        text = ''
          palette = 0=${ theme { colour = "black"; variant = "light"; } }
          palette = 1=${ theme { colour = "blue"; subVariant = "dim"; variant = "light"; } }
          palette = 2=${ theme { colour = "purple"; subVariant = "bright"; variant = "light"; } }
          palette = 3=${ theme { colour = "grey"; variant = "light"; } }
          palette = 4=${ theme { colour = "cyan"; subVariant = "dim"; variant = "light"; } }
          palette = 5=${ theme { colour = "white"; variant = "light"; } }
          palette = 6=${ theme { colour = "yellow"; subVariant = "dim"; variant = "light"; } }
          palette = 7=${ theme { colour = "purple"; subVariant = "dim"; variant = "light"; } }
          palette = 8=${ theme { colour = "red"; subVariant = "bright"; variant = "light"; } }
          palette = 9=${ theme { colour = "orange"; subVariant = "bright"; variant = "light"; } }
          palette = 10=${ theme { colour = "yellow"; variant = "light"; } }
          palette = 11=${ theme { colour = "green"; subVariant = "bright"; variant = "light"; } }
          palette = 12=${ theme { colour = "cyan"; variant = "light"; } }
          palette = 13=${ theme { colour = "blue"; subVariant = "bright"; variant = "light"; } }
          palette = 14=${ theme { colour = "purple"; variant = "light"; } }
          palette = 15=${ theme { colour = "orange"; subVariant = "dim"; variant = "light"; } }
          background = ${ theme { colour = "black"; subVariant = "dim"; variant = "light"; } }
          foreground = ${ theme { colour = "white"; subVariant = "dim"; variant = "light"; } }
          cursor-color = ${ theme { colour = "yellow"; subVariant = "dim"; variant = "light"; } }
          selection-background = ${ theme { colour = "green"; subVariant = "dim"; variant =
            "light"; } }
          selection-foreground = ${ theme { colour = "black"; subVariant = "bright"; variant =
            "light"; } }
        '';
        target = "${config.xdg.configHome}/ghostty/themes/crepuscular-dawn";
      };
    };
  };
}

/**
 * TODO: once the ghostty `pkg` is no longer broken on macos
 * programs = {
 *   ghostty = {
 *     enable = true;
 *     enableFishIntegration = true;
 *     installBatSyntax = true;
 *     settings = {
 *       adjust-cell-height = "80%";
 *       adjust-cursor-height = "100%";
 *       auto-update = "check";
 *       background-blur-radius = 20;
 *       background-opacity = 0.8;
 *       cursor-opacity = 0.9;
 *       cursor-style-blink = true;
 *       desktop-notifications = true;
 *       font-family = "CommitMono Nerd Font Propo";
 *       keybind = "global:super+grave_accent=toggle_quick_terminal";
 *       macos-auto-secure-input = true;
 *       macos-option-as-alt = "left";
 *       macos-secure-input-indication = true;
 *       minimum-contrast = 1.1;
 *       mouse-hide-while-typing = true;
 *       mouse-scroll-multiplier = 0.2;
 *       quick-terminal-position = "top";
 *       window-colorspace = "display-p3";
 *       window-padding-balance = true;
 *       window-padding-x = 12;
 *       window-padding-y = 12;
 *       window-theme = "auto";
 *       window-vsync = true;
 *     };
 *   };
 * };
 */
