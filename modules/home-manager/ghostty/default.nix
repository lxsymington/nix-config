{pkgs, ...}:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    
    settings = {
      "adjust-cell-height" = "75%";
      "background-opacity" = "0.95";
      "background-blur" = "macos-glass-regular";
      "font-family" = "\"CommitMono Nerd Font Propo\"";
      "font-family-bold" = "\"CommitMono Nerd Font Propo Bold\"";
      "font-family-italic" = "\"CommitMono Nerd Font Propo Italic\"";
      "font-family-bold-italic" = "\"CommitMono Nerd Font Propo Bold Italic\"";
      "font-size" = "12";
      "font-thicken" = "true";
      "macos-option-as-alt" = "true";
      "notify-on-command-finish" = "unfocused";
      "notify-on-command-finish-action" = "bell,notify";
      "notify-on-command-finish-after" = "1m30s";
      "window-padding-x" = "20";
      "window-padding-y" = "20";
      "window-padding-balance" = "true";
    };
    
    enableFishIntegration = true;
  };
}
