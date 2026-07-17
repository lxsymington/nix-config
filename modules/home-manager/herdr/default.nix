{config, pkgs, lib, ...}: {
  programs.herdr = {
    enable = true;
    package = pkgs.herdr;
    settings = {
      keys = {
        prefix = "ctrl+g";
      };
      onboarding = false;
      terminal = {
        default_shell = "${pkgs.fish}/bin/fish";
        new_cwd = "follow";
        shell_mode = "auto";
      };
      theme = {
        auto_switch = true;
        dark_name = "terminal";
        light_name = "terminal";
        name = "terminal";
      };
      ui = {
        agent_panel_sort = "priority";
        hide_tab_bar_when_single_tab = false;
        sidebar_max_width = 60;
        sidebar_min_width = 20;
        sidebar_width = 40;
        sound = {
          enabled = true;
        };
        toast = {
          delivery = "terminal";
        };
      };
    };
  };
}
