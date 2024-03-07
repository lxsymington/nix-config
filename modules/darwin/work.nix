{ inputs, config, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      # GUI applications
      pritunl-ssh
      teams
    ];
  };

  # bootstrap home manager using system config
  hm = import ../home-manager/work.nix;

  homebrew = {
    brews = [
      "ruby" # Required for AUTO_OPS
    ];
    casks = [
      "pritunl"
      # "https://raw.githubusercontent.com/Homebrew/homebrew-cask/6bf26425d09c020c4accb5cb958112ead452e5fd/Casks/pritunl.rb" # Pritunl
    ];
  };
}
