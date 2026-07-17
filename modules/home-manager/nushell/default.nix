{ pkgs, ... }: {
  programs = {
    nushell = {
      enable = true;
      settings = {
        show_banner = false;
      };
      shellAliases = {
        ll = "ls -l";
        la = "ls -a";
        lla = "ls -la";
      };
      configFile = {
        text = ''
          mkdir ($nu.data-dir | path join "vendor/autoload")
          starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

          $env.config.buffer_editor = ^nvim
          $env.config.use_ls_colors = true

          alias nu-open = open
          alias open = ^open
        '';
      };
      plugins = with pkgs.nushellPlugins; [
        polars
        query
      ];
    };
  };
}
