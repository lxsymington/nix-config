{ ... }:

let
  theme = import ../../colours.nix;
in
{
  programs = {
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        default_layout = "default";
        default_mode = "locked";
        pane_frames = false;
        simplified_ui = true;
        styled_underlines = true;
        themes = {
          default = {
            fg = theme { colour = "white"; subVariant = "dim"; };
            bg = theme { colour = "grey"; subVariant = "dim"; };
            black = theme { colour = "black"; };
            red = theme { colour = "red"; subVariant = "dim"; };
            green = theme { colour = "green"; subVariant = "dim"; };
            yellow = theme { colour = "yellow"; subVariant = "dim"; };
            blue = theme { colour = "blue"; subVariant = "dim"; };
            magenta = theme { colour = "purple"; subVariant = "dim"; };
            cyan = theme { colour = "cyan"; subVariant = "dim"; };
            white = theme { colour = "white"; subVariant = "bright"; };
            orange = theme { colour = "orange"; subVariant = "dim"; };
          };
        };
      };
    };
  };
}
