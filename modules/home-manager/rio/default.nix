{ pkgs, ... }:

let
  fontFamily = "CommitMono Nerd Font Propo";
  theme = import ../../colours.nix;
in
{
  programs = {
    rio = {
      enable = true;
      settings = {
        editor = "${pkgs.neovim}/bin/nvim";
        blinking-cursor = true;
        option-as-alt = "both";
        fonts = {
          size = 14;
          regular = {
            family = fontFamily;
            style = "normal";
            weight = 400;
          };
          bold = {
            family = fontFamily;
            style = "normal";
            weight = 800;
          };
          italic = {
            family = fontFamily;
            style = "italic";
            weight = 400;
          };
          bold-italic = {
            family = fontFamily;
            style = "italic";
            weight = 800;
          };
        };
        colors = {
          background = theme { colour = "black"; };
          foreground = theme { colour = "white"; };
          comment = theme { colour = "grey"; };
          cyan = theme { colour = "cyan"; };
          green = theme { colour = "green"; };
          orange = theme { colour = "orange"; };
          pink = theme { colour = "purple"; variant = "light"; };
          purple = theme { colour = "purple"; };
          red = theme { colour = "red"; };
          yellow = theme { colour = "yellow"; };
        };
      };
    };
  };
}
