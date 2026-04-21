{...}: {
  environment = {
    systemPackages = [];
  };

  # bootstrap home manager using system config
  hm = import ../home-manager/work.nix;
}
