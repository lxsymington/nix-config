{pkgs, ...}: {
  programs = {
    rio = {
      enable = true;
      settings = {
        editor = "${pkgs.neovim}/bin/nvim";
        blinking-cursor = true;
        option-as-alt = "both";
      };
    };
  };
}
