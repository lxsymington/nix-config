{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
  
  xdg = {
    configFile = {
      nvim = {
        enable = true;
        source = ./config;
        recursive = true;
      };
    };
  };
}
