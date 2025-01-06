{
  inputs,
  config,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [];
  };

  # bootstrap home manager using system config
  hm = import ../home-manager/work.nix;
}
