{ inputs, config, pkgs, ... }:
{
  imports = [
    ../common.nix
    ./core.nix
    ./preferences.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # GUI applications
      pritunl-ssh
      teams
    ];
  };
  
  homebrew = {
    brews = [
      "ruby" # Required for AUTO_OPS
    ];
    casks = [
      # "pritunl"
      "https://raw.githubusercontent.com/Homebrew/homebrew-cask/6bf26425d09c020c4accb5cb958112ead452e5fd/Casks/pritunl.rb" # Pritunl
    ];
  };
}
