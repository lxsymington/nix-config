{ config
, pkgs
, ...
}: {
  xdg = {
    configFile = {
      ghostty = {
        enable = true;
        recursive = true;
        source = ./ghostty.config;
        target = "${config.xdg.configHome}/.config/ghostty/config";
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
