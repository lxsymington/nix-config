{ config, pkgs, ... }@args: {
  imports = builtins.traceVerbose (builtins.attrNames args) [
    ../common.nix
  ];

  environment = {
    enableAllTerminfo = true;

    shellAliases = {
      renix = "nixos-rebuild switch --flake ~/.config/lxs";
    };

    systemPackages = with pkgs; [
      # Node - Volta is used on Darwin
      nodejs_20
    ];
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      recursive
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  system.stateVersion = "23.11";

  user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };
}
