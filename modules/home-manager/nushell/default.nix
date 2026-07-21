{pkgs, ...}: {
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
        nu-open = "open";
        open = "^open";
      };
      configFile = {
        text = ''
          mkdir ($nu.data-dir | path join "vendor/autoload")
          starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

          $env.config.buffer_editor = "nvim"
        '';
      };
      plugins = with pkgs.nushellPlugins; [
        polars
        query
      ];
    };
  };
}
