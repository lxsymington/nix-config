{pkgs, ...}: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        lla = "ls -la";
      };
      plugins = with pkgs; [
        nushellPlugins.formats
        nushellPlugins.gstat
        # nushellPlugins.highlight # currently breaks configuration build
        nushellPlugins.query
        # nushellPlugins.skim # incompatible version
        # nushellPlugins.units # incompatible version
      ];
    };
  };
}
